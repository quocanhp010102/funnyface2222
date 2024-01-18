import UIKit

class ListVideoModal: NSObject {
    var id:Int = 0
    var mask:String=""
    var thongtin:String=""
    var image:String=""
   
    var dotuoi:Int=0
    var IDCategories:Int=0
    
    
    func initLoad(_ json:  [String: Any]) -> ListVideoModal{
        if let temp = json["id"] as? Int {id = temp }
        if let temp = json["mask"] as? String { mask = temp }
        if let temp = json["thongtin"] as? String { thongtin = temp }
        if let temp = json["image"] as? String { image = temp }
       
        if let temp = json["dotuoi"] as? Int {dotuoi = temp }
        if let temp = json["IDCategories"] as? Int {IDCategories = temp }
        

        return self
    }
}
