//
//  genbabycalss.swift
//  funnyface2222
//
//  Created by quocanhppp on 21/02/2024.
//

import Foundation

struct benbabymodal: Codable {
    var id : String?
    var thongtin : String?
    var tomLuocText : String?
    var link_nam_goc : String?
    var link_nu_goc : String?
    var link_baby_goc : String?
    var link_da_swap : String?
    var nguoi_swap:String?
    var id_toan_bo_su_kien:String?
    
    mutating func initLoad(_ json:[String:Any]) ->benbabymodal{
        if let temp = json["id"] as? String {id = temp}
        if let temp = json["thongtin"] as? String {thongtin = temp}
        if let temp = json["tomLuocText"] as? String {
            tomLuocText = temp
        }
        if let temp = json["link_nam_goc"] as? String {link_nam_goc = temp}
        if let temp = json["link_nu_goc"] as? String {link_nu_goc = temp}
        if let temp = json["link_baby_goc"] as? String {link_baby_goc = temp}
        if let temp = json["link_da_swap"] as? String {link_da_swap = temp}
        if let temp = json["nguoi_swap"] as? String {nguoi_swap = temp}
        if let temp = json["id_toan_bo_su_kien"] as? String {id_toan_bo_su_kien = temp}

        return self
    }
    
}
