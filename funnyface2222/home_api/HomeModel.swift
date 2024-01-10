
import Foundation


struct HomeModel : Codable {
    var list_sukien : [List_sukien] = [List_sukien]()
    mutating func initLoad(_ json:[String:Any]) -> HomeModel{
        if let data = json["list_sukien"] as? [[String:Any]] {
            for item1 in data{
                var item: List_sukien = List_sukien()
                item = item.initLoad(item1);
                list_sukien.append(item);
                
            }
        }
        return self;
    }

}

struct List_sukien : Codable {
    var sukien : [Sukien] = [Sukien]()
    mutating func initLoad(_ json:[String:Any]) -> List_sukien{
        if let data = json["sukien"] as? [[String:Any]] {
            for item1 in data{
                var item: Sukien = Sukien()
                item = item.initLoad(item1)
                sukien.append(item)
            }
        }
        return self;
    }
}
struct Sukien: Codable {
    var count_comment : Int?
    var count_view : Int?
    var id : Int?
    var id_toan_bo_su_kien : Int?
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
    mutating func initLoad(_ json:[String:Any]) ->Sukien{
        if let temp = json["count_comment"] as? Int {count_comment = temp}
        if let temp = json["count_view"] as? Int {count_view = temp}
        if let temp = json["id"] as? String {
            let idtoanbo = temp
            id = Int(idtoanbo)}
        if let temp = json["id_toan_bo_su_kien"] as? String {
            let idtoanbo = temp
            id_toan_bo_su_kien = Int(temp)
        }
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


struct UploadImage : Codable {
    let data : DataLove?
}

struct DataLove : Codable {
    let url : String?
}

