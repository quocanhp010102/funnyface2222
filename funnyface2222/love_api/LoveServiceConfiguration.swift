//
//  LoveServiceConfiguration.swift
//  FutureLove
//
//  Created by TTH on 25/07/2023.
//

import Foundation
import Alamofire

enum LoveServiceConfiguration {
    case getEvents(Link_img1: String,
                   Link_img2: String,
                   device_them_su_kien: String,
                   ip_them_su_kien : String ,
                   id_user: String,
                   ten_nam: String ,
                   ten_nu: String)
    
}

extension LoveServiceConfiguration: Configuration {
    
    var baseURL: String {
        switch self {
        case .getEvents:
            return Constant.Server.baseAPIURL
        }
    }
    
    var path: String {
        switch self {
        case .getEvents:
            return "getdata"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getEvents:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getEvents( _,_,let  device_them_su_kien,
                         let ip_them_su_kien  ,
                         let id_user,
                         let ten_nam ,
                         let ten_nu):
            let parameters = [
                "device_them_su_kien": device_them_su_kien,
                "ip_them_su_kien": ip_them_su_kien,
                "id_user" : id_user,
                "ten_nam": ten_nam ,
                "ten_nu": ten_nu  ]
            return .requestParameters(parameters: parameters)
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getEvents(let Link_img1,
                        let Link_img2,
                        _,_,_,_,_):
            let headers:[String:String] = ["Link_img1":Link_img1,
                                           "Link_img2": Link_img2]
            return headers
        }
    }
    
    var data: Data? {
        switch self {
            
        default:
            return nil
        }
    }
}

