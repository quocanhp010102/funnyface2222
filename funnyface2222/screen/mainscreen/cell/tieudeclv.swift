//
//  tieudeclv.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 08/01/2024.
//

import UIKit

class tieudeclv: UICollectionViewCell {
    @IBOutlet weak var buttonTD:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonTD.layer.cornerRadius = 20
        buttonTD.layer.borderWidth = 1
        buttonTD.layer.borderColor = UIColor.white.cgColor
    }

}
