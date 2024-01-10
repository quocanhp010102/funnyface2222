//
//  UserSearchTBVCell.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/16/23.
//

import UIKit

class UserSearchTBVCell: UITableViewCell {
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelIpRegister: UILabel!
    @IBOutlet weak var labelDevice_register: UILabel!
    @IBOutlet weak var labelCount_sukien: UILabel!
    @IBOutlet weak var labelCount_comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
