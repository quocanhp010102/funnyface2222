//
//  DetaiModelUser.swift
//  funnyface2222
//
//  Created by quocanhppp on 14/01/2024.
//

//
//  DetailVideoModel.swift
//  FutureLove
//
//  Created by khongtinduoc on 11/15/23.
//

import UIKit

struct DetaiModelUser: Codable {
    var id_saved: String?
    var link_video_goc: String?
    var link_image: String?
    var link_vid_da_swap: String?
    var thoigian_sukien: String?
    var device_tao_vid: String?
    var ip_tao_vid: String?
    var id_user: Int?
  

    mutating func initLoad(_ json:[String:Any]) ->DetaiModelUser{
        if let temp = json["id_saved"] as? String {id_saved = temp}
        if let temp = json["link_video_goc"] as? String {link_video_goc = temp}
        if let temp = json["link_image"] as? String {link_image = temp}
        if let temp = json["link_vid_da_swap"] as? String {link_vid_da_swap = temp}
        if let temp = json["thoigian_sukien"] as? String {thoigian_sukien = temp}
        if let temp = json["device_tao_vid"] as? String {device_tao_vid = temp}
        if let temp = json["ip_tao_vid"] as? String {ip_tao_vid = temp}
        if let temp = json["id_user"] as? Int {id_user = temp}
       
        return self
    }

}
