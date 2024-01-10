//
//  RecentCommentTableViewCell.swift
//  FutureLove
//
//  Created by TTH on 30/07/2023.
//

import UIKit
import AlamofireImage

class RecentCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(model: CommentUser) {
        descriptionLabel.text = model.noi_dung_cmt
        if let url = URL(string: model.avatar_user.asStringOrEmpty()) {
            avatarImage.af.setImage(withURL: url)
        }
        let time = self.getFormattedDate(strDate: model.thoi_gian_release.asStringOrEmpty(),
                                         currentFomat: "yyyy-MM-dd, HH:mm:ss",
                                         expectedFromat: "yyyy-MM-dd")
        dateLabel.text = time
    }
    func getFormattedDate(strDate: String , currentFomat: String, expectedFromat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = currentFomat

        let date : Date = dateFormatterGet.date(from: strDate) ?? Date()

        dateFormatterGet.dateFormat = expectedFromat
        return dateFormatterGet.string(from: date)
    }
}
