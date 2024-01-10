//
//  RegisterModel.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

struct RegisterModel : Codable {
    var message: String?
    mutating func initLoad(_ json:[String:Any]) ->RegisterModel{
        
        if let temp = json["message"] as? String {message = temp}
        return self
    }
}


struct IPAddress: Codable {
    var ip: String = ""
    var city: String = ""
    var region: String = ""
    var country: String = ""
    var loc: String = ""
    var org: String = ""
    var postal: String = ""
    var timezone: String = ""
    var readme: String = ""
    mutating func initLoad(_ json:[String:Any]) ->IPAddress{
        if let temp = json["ip"] as? String {ip = temp}
        if let temp = json["city"] as? String {city = temp}
        if let temp = json["region"] as? String {region = temp}
        if let temp = json["country"] as? String {country = temp}
        if let temp = json["loc"] as? String {loc = temp}
        if let temp = json["org"] as? String {org = temp}
        if let temp = json["postal"] as? String {postal = temp}
        if let temp = json["timezone"] as? String {timezone = temp}
        if let temp = json["readme"] as? String {readme = temp}

        return self
    }

    
}

