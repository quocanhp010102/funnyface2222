//
//  LoginAPI.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import Foundation
import Alamofire
class LoginAPI: BaseAPI<LoginServiceConfiguration> {
    static let shared = LoginAPI()
    
    func Login(email_or_username: String,
               password: String,
               completionHandler: @escaping (Result<LoginModel, ServiceError>) -> Void) {
        fetchData(configuration: .Login(email_or_username: email_or_username ,
                                        password: password),
                  responseType: LoginModel.self) { result in
            completionHandler(result)
        }
    }
    func ResetPassword(mail: String,
                       completionHandler: @escaping (Result<ResetPasswordModel, ServiceError>) -> Void) {
        fetchData(configuration: .postResetPassword(mail: mail),
                  responseType: ResetPasswordModel.self) { result in
            completionHandler(result)
        }
    }
}
