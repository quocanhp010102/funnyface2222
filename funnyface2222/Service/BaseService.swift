

import Foundation
import Alamofire

class BaseAPI<T: Configuration> {
    
    func upload<M: Decodable>(configuration: T,
                              name: String,
                              view:UIView,
                              responseType: M.Type,
                              completionHandler: @escaping (Result<M, ServiceError>) -> Void) {
        guard let imageData = configuration.data else {
            completionHandler(.failure(ServiceError.notFoundData))
            return
        }
        let parameters = generateParams(task: configuration.task)
        let url = configuration.baseURL + configuration.path
        print(url)
        let headers = HTTPHeaders(configuration.headers ?? [:])
        let method = Alamofire.HTTPMethod(rawValue: configuration.method.rawValue)
        
        guard let host = URLComponents(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        AF.upload(multipartFormData: { multipart in
            multipart.append(imageData,
                             withName: name,
                             fileName: "\(name).jpg",
                             mimeType: "image/jpeg")
            for (key, value) in parameters.0 {
                guard let val = value as? String else { return }
                multipart.append(val.data(using: .utf8) ?? Data(), withName: key)
            }
        },to: host,
                  usingThreshold: UInt64(),
                  method: method,
                  headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
            view.makeToast("Upload Progress: \(progress.fractionCompleted)", position: .top)
        }).responseDecodable(of: M.self) { response in
            guard let existData = response.data else {
                completionHandler(.failure(ServiceError.notFoundData))
                return
            }

            guard let httpResponse = response.response else {
                completionHandler(.failure(ServiceError.notFoundData))
                return
            }
            
            guard self.isSuccess(httpResponse.statusCode) else {
                completionHandler(.failure(.somethinkWrong))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObj = try decoder.decode(M.self, from: existData)
                completionHandler(.success(responseObj))
            } catch {
                print("\n----- Parse Model Error: \n", error)
                print("\n----- End:")
                //let errorPrint = "\n----- Parse Model Error: \n" + error.localizedDescription.utf8CString
//                view.makeToast(errorPrint, position: .top)
                completionHandler(.failure(.parseError))
            }
        }
    }
    
    func fetchData<M: Decodable>(configuration: T,
                                 responseType: M.Type,
                                 completionHandler: @escaping (Result<M, ServiceError>) -> Void) {
        
        let parameters = generateParams(task: configuration.task)
        let url = configuration.baseURL + configuration.path.escape()
        guard var components = URLComponents(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }

        print(url)
        if configuration.method == HTTPMethod.get {
            components.queryItems = parameters.0.map { (key, value) in
                URLQueryItem(name: key, value: "\(value)")
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        guard let url = components.url else {
            completionHandler(.failure(.urlError))
            return
        }
        // Create request
        let request = self.generateRequest(url: url,
                                           method: configuration.method.rawValue,
                                           headers: configuration.headers ?? [:])
        
        if configuration.method == HTTPMethod.post {
            let postString = self.getPostString(params: parameters.0)
            request.httpBody = postString.data(using: .utf8)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest,
                                                  completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    let errorMessage = error?.localizedDescription ?? "Server Error"
                    completionHandler(.failure(ServiceError.init(issueCode: .initValue(value: errorMessage))))
                    return
                }
                guard let existData = data, let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(ServiceError.notFoundData))
                    return
                }
                
                guard (try? JSONSerialization.jsonObject(with: existData, options: [])) != nil else {
                    completionHandler(.failure(.jsonError))
                    return
                }
                
                guard self.isSuccess(httpResponse.statusCode) else {
                    completionHandler(.failure(.somethinkWrong))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseObj = try decoder.decode(M.self, from: existData)
                    completionHandler(.success(responseObj))
                } catch {
                    print("\n----- Parse Model Error: \n", error)
                    print("\n ----- JSON", existData.base64EncodedString())
                    print("\n----- End:")
                    completionHandler(.failure(.parseError))
                }
            }
        })
        
        dataTask.resume()
    }
    
    private func generateRequest(url: URL, method: String, headers: [String:String]) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 300.0)
        request.httpMethod = method
        request.setValue("application/x-www-form-urlencoded charset=utf-8",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key
            )
        }
//        if let token = AppConstant.accessToken {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        return request
    }
    
    private func generateParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }

    }
    
    private func getPostString(params: [String: Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    private func isSuccess(_ code: Int) -> Bool {
        switch code {
        case 200...304:
            return true
        default:
            return false
        }
    }
}
