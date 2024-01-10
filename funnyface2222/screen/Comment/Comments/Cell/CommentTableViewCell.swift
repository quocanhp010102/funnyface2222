//
//  CommentTableViewCell.swift
//  ForeverLove
//
//  Created by TTH on 11/07/2023.
//

import UIKit
import AlamofireImage

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var buttonReport: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(model:DataComment) {
        if let url = URL(string: model.avatar_user ?? "") {
            imageAvatar.af.setImage(withURL: url)
        }
        
        labelName.text = " ip: \(model.dia_chi_ip ?? "")"
        labelDescription.text = model.noi_dung_cmt
        
        let dateString = model.thoi_gian_release ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let targetDate = dateFormatter.date(from: dateString) else {
            return
        }

        let currentTime = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate, to: currentTime)
        
        
        var result = ""
        if let years = components.year, years > 0 {
            result = "\(years) y"
        } else if let months = components.month, months > 0 {
            result = "\(months) m"
        } else if let days = components.day, days > 0 {
            result = "\(days) d"
        } else if let hours = components.hour, hours > 0 {
            result = "\(hours) h"
        } else if let minutes = components.minute, minutes > 0 {
            result = "\(minutes) m"
        } else if let seconds = components.second, seconds > 0 {
            result = "\(seconds) s"
        }
        self.labelTime.text = result
 
    }
    
  
}
