//
//  LoveModel.swift
//  FutureLove
//
//  Created by TTH on 25/07/2023.
//

import Foundation

struct LoveModel : Codable {
    var sukien : [DataGenEvent] = [DataGenEvent]()
    mutating func initLoad(_ json: [String:Any]) -> LoveModel{
        if let temp = json["sukien"] as? [[String:Any]] {
            for item in temp
            {
                var item1:DataGenEvent = DataGenEvent()
                item1 = item1.initLoad(item)
                sukien.append(item1)
            }
        }
        return self
    }

}

//struct DataGenEvent : Codable {
//    let link_img : String?
//    let id_template : Int?
//    let id_user : String?
//    let id_toan_bo_su_kien: Int?
//    let imagecouple : String?
//    let imagehusband : String?
//    let imagewife : String?
//    let phantram_loading : Int?
//    let so_thu_tu_su_kien : Int?
//    let tensukien : String?
//    let thoigian : String?
//    let thongtin : String?
//    let tomluoc : String?
//    let vtrinam : String?
//
//    mutating func initLoad(_ json: [String:Any]) -> DataComment{
//        if let temp = json["link_img"] as? String {avatar_user = temp}
//        if let temp = json["device_cmt"] as? String {device_cmt = temp}
//        if let temp = json["dia_chi_ip"] as? String {dia_chi_ip = temp}
//        if let temp = json["id_comment"] as? Int {id_comment = temp}
//        if let temp = json["id_toan_bo_su_kien"] as? Int {id_toan_bo_su_kien = temp}
//        if let temp = json["id_user"] as? Int {id_user = temp}
//        if let temp = json["imageattach"] as? String {imageattach = temp}
//        if let temp = json["link_nam_goc"] as? String {link_nam_goc = temp}
//        if let temp = json["link_nu_goc"] as? String {link_nu_goc = temp}
//        if let temp = json["noi_dung_cmt"] as? String {noi_dung_cmt = temp}
//        if let temp = json["so_thu_tu_su_kien"] as? Int {so_thu_tu_su_kien = temp}
//        if let temp = json["thoi_gian_release"] as? String {thoi_gian_release = temp}
//        if let temp = json["user_name"] as? String {user_name = temp}
//        if let temp = json["location"] as? String {location = temp}
//        return self
//    }
//}

struct DataGenEvent : Codable {
    var id : String?
    var id_num : Int?
    var tensukien : String?
    var thongtin: String?
    var image : String?
    var nu : String?
    var nam : String?
    var vtrinam : String?
    var tomLuocText : String?
    var link_img : String?
    var numswap : String?
    var id_toan_bo_su_kien : String?
    mutating func initLoad(_ json: [String:Any]) -> DataGenEvent{
        if let temp = json["id"] as? String {id = temp}
        if let temp = json["id_num"] as? Int {id_num = temp}
        if let temp = json["tensukien"] as? String {tensukien = temp}
        if let temp = json["thongtin"] as? String {thongtin = temp}
        if let temp = json["image"] as? String {id_toan_bo_su_kien = temp}
        if let temp = json["nu"] as? String {nu = temp}
        if let temp = json["nam"] as? String {nam = temp}
        if let temp = json["vtrinam"] as? String {vtrinam = temp}
        if let temp = json["tomLuocText"] as? String {tomLuocText = temp}
        if let temp = json["link_img"] as? String {link_img = temp}
        if let temp = json["numswap"] as? String {numswap = temp}
        if let temp = json["id_toan_bo_su_kien"] as? String {id_toan_bo_su_kien = temp}
        return self
    }
}



