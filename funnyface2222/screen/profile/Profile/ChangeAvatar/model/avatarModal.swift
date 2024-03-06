//
//  avatarModal.swift
//  funnyface2222
//
//  Created by quocanhppp on 06/03/2024.
//

import Foundation
import SwiftKeychainWrapper

struct avatarModal : Codable {
    
    var link_img : String?
    
    mutating func initLoad(_ json:[String:Any]) ->avatarModal{
       
        if let temp = json["link_img"] as? String {link_img = temp}
        
        
        return self
    }
}

