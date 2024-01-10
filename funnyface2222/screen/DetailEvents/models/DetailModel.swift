//
//  DetailModel.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import Foundation

struct CommentEvent : Codable {
    var comment : [DataCommentEvent] = [DataCommentEvent]()
    mutating func initLoad(_ json: [String:Any]) -> CommentEvent{
        if let temp = json["comment"] as? [[String:Any]] {
            for item in temp {
                var item2: DataCommentEvent = DataCommentEvent()
                item2.initLoad(item)
                comment.append(item2)
            }
        }
        return self
    }
    
}
struct DataCommentEvent : Codable {
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
    var so_thu_tu_su_kien : Int?
    var thoi_gian_release : String?
    var user_name : String?
    var location: String?
    mutating func initLoad(_ json: [String:Any]) -> DataCommentEvent{
        if let temp = json["avatar_user"] as? String {avatar_user = temp}
        if let temp = json["device_cmt"] as? String {device_cmt = temp}
        if let temp = json["dia_chi_ip"] as? String {dia_chi_ip = temp}
        if let temp = json["id_comment"] as? Int {
            id_comment = temp
        }
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

struct DetailEvent: Codable {
    var sukien : [EventModel] = [EventModel]()
    mutating func initLoad(_ json: [String:Any]) -> DetailEvent{
        if let temp = json["sukien"] as? [[String:Any]] {
            for item in temp {
                var item2: EventModel = EventModel()
                item2 = item2.initLoad(item)
                sukien.append(item2)
            }
        }
        return self
    }
}

struct EventModel: Codable {
    var count_comment : Int?
    var count_view : Int?
    var id : Int?
    var id_user : Int?
    var id_template: Int?
    var link_da_swap : String?
    var link_nam_chua_swap : String?
    var link_nam_goc : String?
    var link_nu_chua_swap : String?
    var link_nu_goc : String?
    var noi_dung_su_kien : String?
    var phantram_loading : Int?
    var real_time : String?
    var so_thu_tu_su_kien : Int?
    var ten_nam : String?
    var ten_nu : String?
    var ten_su_kien : String?
    mutating func initLoad(_ json: [String:Any]) -> EventModel{
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_view"] as? Int {count_view = temp}
        if let temp = json["id"] as? Int {id = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["id_template"] as? Int {id_template = temp}
        if let temp = json["link_da_swap"] as? String {link_da_swap = temp}
        if let temp = json["link_nam_chua_swap"] as? String {link_nam_chua_swap = temp}
        if let temp = json["link_nam_goc"] as? String {link_nam_goc = temp}
        if let temp = json["phantram_loading"] as? Int {phantram_loading = temp}
        if let temp = json["link_nu_chua_swap"] as? String {link_nu_chua_swap = temp}
        if let temp = json["link_nu_goc"] as? String {link_nu_goc = temp}
        if let temp = json["noi_dung_su_kien"] as? String {noi_dung_su_kien = temp}
        if let temp = json["real_time"] as? String {real_time = temp}
        if let temp = json["so_thu_tu_su_kien"] as? Int {so_thu_tu_su_kien = temp}
        if let temp = json["ten_nam"] as? String {ten_nam = temp}
        if let temp = json["ten_nu"] as? String {ten_nu = temp}
        if let temp = json["ten_su_kien"] as? String {ten_su_kien = temp}

        return self
    }
}

struct PostComments: Codable {
    var comment : Comment = Comment()
    mutating func initLoad(_ json: [String:Any]) -> PostComments{
        if let temp = json["comment"] as? [String:Any] {
            comment.initLoad(temp)
        }
        return self
    }

}

struct Comment: Codable {
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
    mutating func initLoad(_ json: [String:Any]) -> Comment{
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
        if let temp = json["thoi_gian_release"] as? String {thoi_gian_release = temp}
        if let temp = json["user_name"] as? String {user_name = temp}
        if let temp = json["location"] as? String {location = temp}
        return self

    }
}
