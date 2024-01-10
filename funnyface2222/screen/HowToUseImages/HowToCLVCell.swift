//
//  HowToCLVCell.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/4/23.
//

import UIKit

class HowToCLVCell: UICollectionViewCell {
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 211/225, green: 165/225, blue: 182/225, alpha: 1.0)

    }

}
