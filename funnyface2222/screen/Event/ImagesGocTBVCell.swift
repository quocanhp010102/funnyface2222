//
//  ImagesGocTBVCell.swift
//  FutureLove
//
//  Created by khongtinduoc on 9/26/23.
//

import UIKit

class ImagesGocTBVCell: UITableViewCell {
    @IBOutlet weak var image1Nam: UIImageView!
    @IBOutlet weak var image2Nu: UIImageView!
    @IBOutlet weak var labelNameNam: UILabel!
    @IBOutlet weak var labelNameNu: UILabel!
    @IBOutlet weak var labelUserNameCreator: UILabel!
    @IBOutlet weak var imageUserName: UIImageView!
    @IBOutlet weak var buttonNam: UIButton!
    @IBOutlet weak var buttonNu: UIButton!
    @IBOutlet weak var buttonUserNameCreator: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        labelNameNam.numberOfLines = 0
        labelNameNam.lineBreakMode = .byWordWrapping
        labelNameNu.numberOfLines = 0
        labelNameNu.lineBreakMode = .byWordWrapping
    }
}
