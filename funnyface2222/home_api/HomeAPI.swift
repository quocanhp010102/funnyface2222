

import Foundation
import UIKit

class HomeAPI: BaseAPI<HomeServiceConfiguration> {
    static let shared = HomeAPI()
    
    func getLovehistory(page: Int,
                        completionHandler: @escaping (Result<HomeModel, ServiceError>) -> Void) {
        fetchData(configuration: .getLovehistory(page: page),
                  responseType: HomeModel.self) { result in
            completionHandler(result)
        }
    }
    

    func uploadImage(key: String,
                     name: String,
                     view:UIView,
                     imageData: Data,
                     completionHandler: @escaping (Result<UploadImage, ServiceError>) -> Void) {
        upload(configuration: .uploadImage(key: key, imageData: imageData),
               name: name,
               view:view,
               responseType: UploadImage.self) { result in
            completionHandler(result)
        }
    }
}
