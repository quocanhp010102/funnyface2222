//
//  DetailCommentTableViewCell.swift
//  FutureLove
//
//  Created by TTH on 28/07/2023.
//

import UIKit
import AlamofireImage
import SwiftKeychainWrapper

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

class DetailCommentTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    
    @IBOutlet weak var buttonReport: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!

    var descriptionMain:String = ""
    var id_comment:String = ""
    var report_reason:String = "No Report"
    var id_user_comment:String = ""
    var linkAvatar:String = ""
    var thoi_gian_release:String = ""
    var noi_dung_cmt:String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        buttonReport.setTitle("", for: .normal)
        buttonDelete.setTitle("", for: .normal)
    }
    
    @IBAction func blockAccountPro(){
        if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
            let number_userPro = number_user + 1
            KeychainWrapper.standard.set(number_userPro, forKey: "number_user")
            if let idUser = (noi_dung_cmt.urlEncoded){
                let idUserNumber = "id_user_" + String(number_userPro)
                KeychainWrapper.standard.set(idUser, forKey: idUserNumber)
            }
        }else{
            KeychainWrapper.standard.set(1, forKey: "number_user")
            if let idUser = id_user_comment.urlEncoded{
                let idUserNumber = "id_user_" + String(1)
                KeychainWrapper.standard.set(idUser, forKey: idUserNumber)
            }
        }
        if let parentVC = self.parentViewController as? DetailEventsViewController{
            if let idUser = id_user_comment.urlEncoded{
                parentVC.reloadBlockAccount(DataXoa:idUser)
            }
        }
        if let parentVC = self.parentViewController as? CommentsViewController{
            if let idUser = id_user_comment.urlEncoded{
                parentVC.reloadBlockAccount(DataXoa:idUser)
            }
        }
    }
    
    @IBAction func reportCommentAction(){
        var reportView = ReportCommentVC()
        reportView.deviceName = self.deviceLabel.text ?? ""
        reportView.userName = self.userNameLabel.text ?? ""
        reportView.location = self.locationLabel.text ?? ""
        reportView.id_user_comment = self.id_user_comment
        reportView.id_comment = self.id_comment
        reportView.id_user_report = id_user_comment //
        reportView.linkAvatar = linkAvatar
        reportView.descriptionMain = self.descriptionMain
        reportView.time = self.thoi_gian_release
        reportView.modalPresentationStyle = .fullScreen
        if let parentVC = self.parentViewController as? DetailEventsViewController{
            parentVC.present(reportView, animated: true, completion: nil)
        }
        if let parentVC = self.parentViewController as? CommentsViewController{
            parentVC.present(reportView, animated: true, completion: nil)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configCell(model: DataCommentEvent) {
        if let url = URL(string: model.avatar_user.asStringOrEmpty()) {
            imageAvatar.af.setImage(withURL: url)
        }
        userNameLabel.text = model.user_name
        descriptionLabel.text = model.noi_dung_cmt
        locationLabel.text = "IP: \(model.dia_chi_ip ?? "") - \(model.location ?? "")"
        deviceLabel.text = "Device: \(model.device_cmt ?? "")"
        
        let dateString = model.thoi_gian_release.asStringOrEmpty()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let targetDate = dateFormatter.date(from: dateString) else {
            return
        }
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate, to: currentDate)
        var result = ""
        if let days = components.day, days > 2 {
            result = "\(dateString)"
        } else if let days = components.day, days > 0 {
            result = "\(days) days ago"
        } else if let hours = components.hour, hours > 0 {
            result = "\(hours) hour ago"
        } else if let minutes = components.minute, minutes > 0 {
            result = "\(minutes) min ago"
        } else if let seconds = components.second, seconds > 0 {
            result = "\(seconds) sec ago"
        } else {
            result = "now"
        }
        self.timeLabel.text = result
    }
    
    func configCellComment(model: DataComment) {
        if let url = URL(string: model.avatar_user.asStringOrEmpty()) {
            imageAvatar.af.setImage(withURL: url)
        }
        userNameLabel.text = model.user_name
        descriptionLabel.text = model.noi_dung_cmt
        locationLabel.text = "IP: \(model.dia_chi_ip ?? "") - \(model.location ?? "")"
        deviceLabel.text = "Device: \(model.device_cmt ?? "")"
        
        let dateString = model.thoi_gian_release.asStringOrEmpty()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let targetDate = dateFormatter.date(from: dateString) else {
            return
        }
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate, to: currentDate)
        var result = ""
        if let days = components.day, days > 2 {
            result = "\(dateString)"
        } else if let days = components.day, days > 0 {
            result = "\(days) days ago"
        } else if let hours = components.hour, hours > 0 {
            result = "\(hours) hour ago"
        } else if let minutes = components.minute, minutes > 0 {
            result = "\(minutes) min ago"
        } else if let seconds = components.second, seconds > 0 {
            result = "\(seconds) sec ago"
        } else {
            result = "now"
        }
        self.timeLabel.text = result
      
    }
    func configCellReComment(model: CommentUser) {
        if let url = URL(string: model.avatar_user.asStringOrEmpty()) {
            imageAvatar.af.setImage(withURL: url)
        }
        userNameLabel.text = model.user_name
        descriptionLabel.text = model.noi_dung_cmt
        locationLabel.text = "IP: \(model.dia_chi_ip ?? "")"
        deviceLabel.text = "Device: \(model.device_cmt ?? "")"
        
        let dateString = model.thoi_gian_release.asStringOrEmpty()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let targetDate = dateFormatter.date(from: dateString) else {
            return
        }
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate, to: currentDate)
        var result = ""
//        if let years = components.year, years > 0 {
//            result = "\(years) years ago"
//    } else
        if let days = components.day, days > 2 {
            result = "\(dateString)"
        } else if let days = components.day, days > 0 {
            result = "\(days) days ago"
        } else if let hours = components.hour, hours > 0 {
            result = "\(hours) hour ago"
        } else if let minutes = components.minute, minutes > 0 {
            result = "\(minutes) min ago"
        } else if let seconds = components.second, seconds > 0 {
            result = "\(seconds) sec ago"
        } else {
            result = "Now"
        }
        self.timeLabel.text = result
      
    }
}

