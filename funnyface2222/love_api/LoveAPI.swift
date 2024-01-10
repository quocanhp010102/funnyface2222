//
//  LoveAPI.swift
//  FutureLove
//
//  Created by TTH on 25/07/2023.
//
import Foundation

class LoveAPI: BaseAPI<LoveServiceConfiguration> {
    static let shared = LoveAPI()
    
    func getEvents(Link_img1: String,
                   Link_img2: String,
                   device_them_su_kien: String,
                   ip_them_su_kien : String ,
                   id_user: String,
                   ten_nam: String ,
                   ten_nu: String,
                   completionHandler: @escaping (Result<LoveModel, ServiceError>) -> Void) {
        fetchData(configuration: .getEvents(Link_img1: Link_img1,
                                            Link_img2: Link_img2,
                                            device_them_su_kien: device_them_su_kien,
                                            ip_them_su_kien: ip_them_su_kien,
                                            id_user: id_user,
                                            ten_nam: ten_nam,
                                            ten_nu: ten_nu),
                  responseType: LoveModel.self) { result in
            completionHandler(result)
        }
    }
}
