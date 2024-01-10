
import Foundation

struct CommentsModel : Codable {
    var comment : [DataComment] = [DataComment]()
    
    mutating func initLoad(_ json: [String:Any]) -> CommentsModel{
        if let temp = json["comment"] as? [[String:Any]]
        {
            for item in temp {
                var item1: DataComment = DataComment()
                item1 = item1.initLoad(item)
                comment.append(item1)
            }
        }
        

        return self
    }
}

struct DataComment : Codable {
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
    mutating func initLoad(_ json: [String:Any]) -> DataComment{
        if let temp = json["avatar_user"] as? String {avatar_user = temp}
        if let temp = json["device_cmt"] as? String {device_cmt = temp}
        if let temp = json["dia_chi_ip"] as? String {dia_chi_ip = temp}
        if let temp = json["id_comment"] as? Int {id_comment = temp}
        if let temp = json["id_toan_bo_su_kien"] as? String {
            id_toan_bo_su_kien = Int(temp)
        }
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
