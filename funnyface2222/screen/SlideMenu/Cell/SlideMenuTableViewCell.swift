//
//  SlideMenuTableViewCell.swift
//  FutureLove
//
//  Created by TTH on 29/07/2023.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameEventLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configCell(model: EventModel) {
        nameEventLabel.text = model.ten_su_kien
        
    }
    
}
