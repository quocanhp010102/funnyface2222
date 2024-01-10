//
//  ProfileModel.swift
//  FutureLove
//
//  Created by TTH on 30/07/2023.
//

import Foundation

struct RecentCommentModel : Codable {
    var comment_user : [CommentUser] = [CommentUser]()
    
    mutating func initLoad(_ json: [String:Any]) -> RecentCommentModel{
        if let temp = json["comment_user"] as? [[String:Any]]
        {
            for item in temp {
                var item1: CommentUser = CommentUser()
                item1 = item1.initLoad(item)
                comment_user.append(item1)
            }
        }
        return self
    }
    
}

struct CommentUser : Codable {
    var avatar_user : String?
    var device_cmt : String?
    var dia_chi_ip : String?
    var id_comment : Int?
    var id_toan_bo_su_kien : Int?
    var id_user : Int?
    var imageattach : String?
    var link_nam_goc : String?
    var link_nu_goc : String?
    var noi_dung_cmt : String?
    var thoi_gian_release : String?
    var user_name : String?
    var location: String?
    var so_thu_tu_su_kien : Int?
    mutating func initLoad(_ json: [String:Any]) -> CommentUser{
        if let temp = json["avatar_user"] as? String {avatar_user = temp}
        if let temp = json["device_cmt"] as? String {device_cmt = temp}
        if let temp = json["dia_chi_ip"] as? String {dia_chi_ip = temp}
        if let temp = json["id_comment"] as? Int {id_comment = temp}
        if let temp = json["id_toan_bo_su_kien"] as? Int {id_toan_bo_su_kien = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["imageattach"] as? String {imageattach = temp}
        if let temp = json["link_nam_goc"] as? String {link_nam_goc = temp}
        if let temp = json["link_nu_goc"] as? String {link_nu_goc = temp}
        if let temp = json["noi_dung_cmt"] as? String {noi_dung_cmt = temp}
        if let temp = json["so_thu_tu_su_kien"] as? Int {so_thu_tu_su_kien = temp}
        if let temp = json["thoi_gian_release"] as? String {thoi_gian_release = temp}
        if let temp = json["user_name"] as? String {user_name = temp}
        if let temp = json["location"] as? String {location = temp}
        return self
    }
    
}

struct ProfileModel: Codable {
    var count_comment: Int?
    var count_sukien: Int?
    var count_view : Int?
    var device_register: String?
    var email: String?
    var id_user: Int?
    var ip_register: String?
    var link_avatar: String?
    var user_name: String?
    var ketqua: String?
    mutating func initLoad(_ json:[String:Any]) ->ProfileModel{
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_sukien"] as? Int {count_sukien = temp}
        if let temp = json["device_register"] as? String {device_register = temp}
        if let temp = json["email"] as? String {email = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["ip_register"] as? String {ip_register = temp}
        if let temp = json["link_avatar"] as? String {link_avatar = temp}
        if let temp = json["user_name"] as? String {user_name = temp}
        if let temp = json["ketqua"] as? String {ketqua = temp}
        return self
    }

}
