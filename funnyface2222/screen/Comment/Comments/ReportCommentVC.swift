//
//  ReportCommentVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/7/23.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class ReportCommentVC: UIViewController {
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var textViewInput: UITextView!
    @IBOutlet weak var buttonBackApp: UIButton!

    var linkAvatar:String = ""
    var userName:String = ""
    var descriptionMain:String = ""
    var time:String = ""
    var location:String = ""
    var deviceName:String = ""
    var id_user_comment:String = ""
    var id_comment:String = ""
    var id_user_report:String = ""
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    @IBAction func NextPostReport(){
        if let id_user_report: Int = KeychainWrapper.standard.integer(forKey: "id_user"){
            let param = ["id_comment": self.id_comment,
                         "report_reason": "\(textViewInput.text) ",
                         "id_user_report": "\(id_user_report)",
                         "id_user_comment": id_user_comment]
            APIService.shared.reportComment(param: param) {result, error in
                if let success = result {
                    let alert = UIAlertController(title: "Send Report Ok", message: "Please Wait For Admin Check Your Report", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done Report", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.dismiss(animated: true)
                        case .cancel:
                            self.dismiss(animated: true)
                        case .destructive:
                            self.dismiss(animated: true)
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            print("NO LOGIN")
            let alert = UIAlertController(title: "Alert", message: "Please Login Account", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Login To Report", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBackApp.setTitle("", for: .normal)
        userNameLabel.text = userName
        descriptionLabel.text = descriptionMain
        timeLabel.text = time
        locationLabel.text = location
        deviceLabel.text = deviceName
        let url = URL(string: linkAvatar )
        let processor = DownsamplingImageProcessor(size: imageAvatar.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        imageAvatar.kf.indicatorType = .activity
        imageAvatar.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    
}
