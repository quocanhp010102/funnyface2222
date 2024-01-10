//
//  APIKeyIMGBB.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/10/23.
//

import UIKit

struct APIKeyIMGBB: Codable {
    var APIKey : String?
    var Account : String?
    var pass : String?
    
    mutating func initLoad(_ json:[String:Any]) ->APIKeyIMGBB{
        if let temp = json["APIKey"] as? String {APIKey = temp}
        if let temp = json["Account"] as? String {Account = temp}
        if let temp = json["pass"] as? String {
            pass = temp
        }
        return self
    }

}

struct UserSearchModel: Codable {
    var id_user: Int?
    var link_avatar: String?
    var user_name: String?
    var ip_register: String?
    var device_register: String?
    var email: String?
    var count_sukien:Int?
    var count_comment: Int?
    var count_view: Int?
    
    mutating func initLoad(_ json:[String:Any]) ->UserSearchModel{
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["link_avatar"] as? String {link_avatar = temp}
        if let temp = json["user_name"] as? String {user_name = temp}
        if let temp = json["ip_register"] as? String {ip_register = temp}
        if let temp = json["device_register"] as? String {device_register = temp}
        if let temp = json["email"] as? String {email = temp}
        if let temp = json["count_sukien"] as? Int {count_sukien = temp}
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_view"] as? Int {count_view = temp}
        return self
    }

}
