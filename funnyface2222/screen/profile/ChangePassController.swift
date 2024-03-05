//
//  ChangePassController.swift
//  funnyface2222
//
//  Created by quocanhppp on 05/03/2024.
//

import UIKit

class ChangePassController: UIViewController {
    @IBOutlet weak var passs: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var newpassagain: UITextField!
    @IBOutlet weak var hienpass: UIButton!
    @IBOutlet weak var hienpassnew: UIButton!
    @IBOutlet weak var hienpassnewagain: UIButton!
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true)
    }
    @IBAction func actionBtnHiden(_ sender: Any) {
      
        if passs.isSecureTextEntry == true {
            passs.isSecureTextEntry = false
        } else {
            passs.isSecureTextEntry = true
        }
    }
    @IBAction func actionBtnHiden2(_ sender: Any) {
      
        if newpass.isSecureTextEntry == true {
            newpass.isSecureTextEntry = false
        } else {
            newpass.isSecureTextEntry = true
        }
    }
    @IBAction func actionBtnHiden3(_ sender: Any) {
      
        if newpassagain.isSecureTextEntry == true {
            newpassagain.isSecureTextEntry = false
        } else {
            newpassagain.isSecureTextEntry = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hienpass.setTitle("", for: .normal)
        hienpassnew.setTitle("", for: .normal)
        hienpassnewagain.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
