//
//  VideoModel.swift
//  FutureLove
//
//  Created by khongtinduoc on 11/3/23.
//

import UIKit
import AVFoundation

struct TempleVideoModel: Codable {
    var id : Int?
    var linkgoc : String?
    var noidung : String?
    var linkThump : String?
    mutating func initLoad(_ json:[String:Any]) ->TempleVideoModel{
        if let temp = json["id"] as? Int {id = temp}
        if let temp = json["linkgoc"] as? String {linkgoc = temp}
        if let temp = json["noidung"] as? String {
            noidung = temp
        }
        if let temp = json["Field4"] as? String {linkThump = temp}
        return self
    }
    
}


struct Temple2VideoModel: Codable {
    var id : Int?
    var id_categories:Int?
    var name_categories:String?
    var detail:String?
    var age_video:Int?
    var chung_toc:String?
    var gioi_tinh : String?
    var link_video : String?
    var mau_da : String?
    var noi_dung : String?
    var thumbnail : String?
    mutating func initLoad(_ json:[String:Any]) ->Temple2VideoModel{
        if let temp = json["id"] as? Int {id = temp}
        if let temp = json["id_categories"] as? Int {id_categories = temp}
        if let temp = json["name_categories"] as? String {name_categories = temp}
        if let temp = json["detail"] as? String {detail = temp}
        if let temp = json["age_video"] as? Int {age_video = temp}
        if let temp = json["chung_toc"] as? String {
            chung_toc = temp
        }
        if let temp = json["gioi_tinh"] as? String {gioi_tinh = temp}
        if let temp = json["link_video"] as? String {link_video = temp}
        if let temp = json["mau_da"] as? String {mau_da = temp}
        if let temp = json["noi_dung"] as? String {noi_dung = temp}
       
        if let temp = json["thumbnail"] as? String {thumbnail = temp}
        return self
    }
    
}

struct ResultVideoModel: Codable {
    var id_video : String?
    var link_image : String?
    var link_vid_swap : String?
    var ten_su_kien : String?
    var noidung_sukien : String?
    var id_video_swap : String?
    var thoigian_taovid : String?
    var id_user : Int?
    var count_comment : Int?
    var count_view : Int?
    var thoigian_taosk:String?
    var thoigian_swap:String?
    
    mutating func initLoad(_ json:[String:Any]) ->ResultVideoModel{
        if let temp = json["id_video"] as? String {id_video = temp}
        if let temp = json["link_image"] as? String {link_image = temp}
        if let temp = json["link_vid_swap"] as? String {
            link_vid_swap = temp
        }
        if let temp = json["thoigian_swap"] as? String {thoigian_swap = temp}
        if let temp = json["thoigian_taosk"] as? String {thoigian_taosk = temp}
        if let temp = json["ten_su_kien"] as? String {ten_su_kien = temp}
        if let temp = json["noidung_sukien"] as? String {noidung_sukien = temp}
        if let temp = json["id_video_swap"] as? String {id_video_swap = temp}
        if let temp = json["thoigian_taovid"] as? String {thoigian_taovid = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_view"] as? Int {count_view = temp}

        return self
    }
    
}

struct VideoModel: Codable {
    var id_video : String?
    var link_image : String?
    var link_vid_swap : String?
    var ten_su_kien : String?
    var noidung_sukien : String?
    var id_video_swap : String?
    var thoigian_taovid : String?
    var id_user : Int?
    var count_comment : Int?
    var count_view : Int?
    
    mutating func initLoad(_ json:[String:Any]) ->VideoModel{
        if let temp = json["id_video"] as? String {id_video = temp}
        if let temp = json["link_image"] as? String {link_image = temp}
        if let temp = json["link_vid_swap"] as? String {
            link_vid_swap = temp
        }
        if let temp = json["ten_su_kien"] as? String {ten_su_kien = temp}
        if let temp = json["noidung_sukien"] as? String {noidung_sukien = temp}
        if let temp = json["id_video_swap"] as? String {
            id_video_swap = temp
        }
        if let temp = json["thoigian_taovid"] as? String {thoigian_taovid = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
        if let temp = json["count_comment"] as? Int {
            count_comment = temp
        }
        if let temp = json["count_view"] as? Int {count_view = temp}
        return self
    }
    
}
