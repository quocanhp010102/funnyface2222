//
//  celleventduoi.swift
//  funnyface2222
//
//  Created by quocanhppp on 24/01/2024.
//

import UIKit

class celleventduoi: UICollectionViewCell {
    @IBOutlet weak var lablenamesk:UILabel!
    @IBOutlet weak var lablenamesk2:UILabel!
    @IBOutlet weak var lablenamesk3:UILabel!
    @IBOutlet weak var lablenamesk4:UILabel!
    @IBOutlet weak var lablenamesk5:UILabel!
    @IBOutlet weak var labelUserName:UILabel!
    @IBOutlet weak var imageUserAvatar:UIImageView!
    var profile:ProfileModel = ProfileModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUserAvatar.layer.cornerRadius = imageUserAvatar.bounds.width / 2
        imageUserAvatar.clipsToBounds = true
        // Initialization code
    }

}
