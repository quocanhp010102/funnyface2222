//
//  RegisterServiceConfiguration.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//



import Foundation
import Alamofire

enum RegisterServiceConfiguration {
    case Register(email: String, password: String, user_name: String,
                  link_avatar: String, ip_register: String, device_register: String )
    case getIP
}

extension RegisterServiceConfiguration: Configuration {
    
    var baseURL: String {
        switch self {
        case .Register:
            return Constant.Server.baseAPIURL
        case .getIP:
            return Constant.Server.IPURL
        }
    }
    
    var path: String {
        switch self {
        case .Register:
            return "register"
        case .getIP:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Register:
            return .post
        case .getIP:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .Register(let email, let password, let user_name, let link_avatar, let  ip_register, let device_register):
            let parameters = [
                "email": email,
                "password": password,
                "user_name" : user_name,
                "link_avatar": link_avatar,
                "ip_register" : ip_register,
                "device_register": device_register
            ]
            return .requestParameters(parameters: parameters)
        case .getIP:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .Register:
            return [:]
        case .getIP:
            return [:]
        }
    }
    
    var data: Data? {
        switch self {
        case .Register:
            return nil
        case .getIP:
            return nil
        }
    }
}
