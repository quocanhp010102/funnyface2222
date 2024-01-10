//
//  DetailHowToVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/5/23.
//

import UIKit

class DetailHowToVC: UIViewController {
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var textViewMain: UITextView!
    @IBOutlet weak var buttonBack: UIButton!

    var textMainPro = ""
    var imageLink:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonBack.setTitle("", for: UIControl.State.normal)
        imageCover.image = UIImage(named: imageLink)
        textViewMain.isEditable = false
        textViewMain.text = textMainPro
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
