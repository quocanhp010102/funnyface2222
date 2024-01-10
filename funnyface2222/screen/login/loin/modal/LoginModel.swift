//
//  LoginModel.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import Foundation
import SwiftKeychainWrapper

struct LoginModel : Codable {
    var count_comment : Int?
    var count_sukien : Int?
    var device_register : String?
    var email : String?
    var id_user : Int?
    var ip_register : String?
    var link_avatar : String?
    var user_name : String?
    var ketqua: String?
    var token:String?
    mutating func initLoad(_ json:[String:Any]) ->LoginModel{
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_sukien"] as? Int {count_sukien = temp}
        if let temp = json["device_register"] as? String {device_register = temp}
        if let temp = json["email"] as? String {email = temp}
        if let temp = json["token"] as? String {
            token = temp
            KeychainWrapper.standard.set(temp, forKey: "token_login")
        }
        if let temp = json["id_user"] as? Int {
            id_user = temp
            KeychainWrapper.standard.set(id_user ?? 0, forKey: "id_user")
        }
        if let temp = json["ip_register"] as? String {ip_register = temp}
        if let temp = json["link_avatar"] as? String {link_avatar = temp}
        if let temp = json["user_name"] as? String {user_name = temp}
        if let temp = json["message"] as? String {ketqua = temp}
        
        return self
    }
}


struct ResetPasswordModel : Codable {
    var message : String?
    mutating func initLoad(_ json:[String:Any]) ->ResetPasswordModel{
        if let temp = json["detail"] as? String {message = temp}
        return self
    }
}
