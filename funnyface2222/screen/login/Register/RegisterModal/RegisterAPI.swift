//
//  RegisterAPI.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import Foundation

class RegisterAPI: BaseAPI<RegisterServiceConfiguration> {
    static let shared = RegisterAPI()
    
    func Regiter(email: String,
                  password: String,
                  user_name: String,
                  link_avatar: String,
                  ip_register: String,
                  device_register: String,
                 completionHandler: @escaping (Result<RegisterModel, ServiceError>) -> Void) {
        fetchData(configuration: .Register(email: email ,
                                           password: password,
                                           user_name: user_name,
                                           link_avatar: link_avatar,
                                           ip_register: ip_register,
                                           device_register: device_register),
                  responseType: RegisterModel.self) { result in
            completionHandler(result)
        }
    }
    func getIP(completionHandler: @escaping (Result<IPAddress, ServiceError>) -> Void) {
        fetchData(configuration: .getIP,
                  responseType: IPAddress.self) { result in
            completionHandler(result)
        }
    }
}
