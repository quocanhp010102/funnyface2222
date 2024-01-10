//
//  LoginServiceConfiguration.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import Foundation


import Foundation

enum LoginServiceConfiguration {
    case Login(email_or_username: String, password: String )
    case postResetPassword(mail: String)
  
}

extension LoginServiceConfiguration: Configuration {
    
    var baseURL: String {
        switch self {
        case .Login:
            return Constant.Server.baseAPIURL
        case .postResetPassword:
            return Constant.Server.baseAPIURL
        }
    }
    
    var path: String {
        switch self {
        case .Login:
            return "login"
        case .postResetPassword:
            return "reset"
       
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        case .postResetPassword:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .Login(let email_or_username, let password):
            let parameters = [
                "email_or_username": email_or_username,
                "password": password ]
            return .requestParameters(parameters: parameters)
        case .postResetPassword(let mail):
            let parameters = ["mail": mail]
            return .requestParameters(parameters: parameters)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .Login:
            return [:]
        case .postResetPassword:
            return [:]
        }
    }
    
    var data: Data? {
        switch self {
        case .Login:
            return nil
        case .postResetPassword:
            return nil
        }
    }
}
