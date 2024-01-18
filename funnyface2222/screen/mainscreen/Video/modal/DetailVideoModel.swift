//
//  DetailVideoModel.swift
//  FutureLove
//
//  Created by khongtinduoc on 11/15/23.
//

import UIKit

struct DetailVideoModel: Codable {
    var noidung: String?
    var id_sukien_video: String?
    var id_video_swap: String?
    var ten_video: String?
    var thoigian_swap: Float?
    var linkimg: String?
    var device_tao_vid: String?
    var thoigian_sukien: String?
    var link_vid_goc: String?
    var ip_tao_vid: String?
    var link_vid_swap: String?
    var link_video_goc: String?
    var idUser: Int?

    mutating func initLoad(_ json:[String:Any]) ->DetailVideoModel{
        if let temp = json["noidung"] as? String {noidung = temp}
        if let temp = json["id_sukien_video"] as? String {id_sukien_video = temp}
        if let temp = json["id_video_swap"] as? String {id_video_swap = temp}
        if let temp = json["ten_video"] as? String {ten_video = temp}
        if let temp = json["thoigian_swap"] as? Float {thoigian_swap = temp}
        if let temp = json["linkimg"] as? String {linkimg = temp}
        if let temp = json["device_tao_vid"] as? String {device_tao_vid = temp}
        if let temp = json["thoigian_sukien"] as? String {thoigian_sukien = temp}
        if let temp = json["device_tao_vid"] as? String {device_tao_vid = temp}
        if let temp = json["ip_tao_vid"] as? String {ip_tao_vid = temp}
        if let temp = json["link_vid_swap"] as? String {link_vid_swap = temp}
        if let temp = json["link_vid_goc"] as? String {link_vid_goc = temp}
        if let temp = json["link_video_goc"] as? String {link_video_goc = temp}
        return self
    }

}
