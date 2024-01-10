

import Foundation
import Alamofire

enum HomeServiceConfiguration {
    case getLovehistory(page: Int)
    case uploadImage(key: String,
                     imageData: Data)
}

extension HomeServiceConfiguration: Configuration {
    
    var baseURL: String {
        switch self {
        case .getLovehistory:
            return Constant.Server.baseAPIURL
        case .uploadImage:
            return Constant.Server.imgAPIURL
        }
    }
    
    var path: String {
        switch self {
        case .getLovehistory(let page):
            return "lovehistory/page/\(page)"
        case .uploadImage:
            return "1/upload"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLovehistory:
            return .get
        case .uploadImage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getLovehistory:
            return .requestPlain
        case .uploadImage(let key, _):
            return .requestParameters(parameters: ["key": key])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImage:
            return [
                "Content-Type": "application/json; charset=UTF-8",
                "accept": "application/json"
            ]
        default:
            return [:]
        }
    }
    
    var data: Data? {
        switch self {
        case .uploadImage(_, let imageData):
            return imageData
        default:
            return nil
        }
    }
}
