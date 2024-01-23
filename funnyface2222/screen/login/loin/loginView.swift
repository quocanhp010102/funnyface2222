//
//  loginView.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 05/01/2024.
//

//
//  LoginViewController.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit
import Toast_Swift
import SwiftKeychainWrapper
import SwiftVideoBackground

class loginView: BaseViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var fbbtn: UIButton!
    @IBOutlet weak var ggbtn: UIButton!
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var oldLoginLabel: UILabel!
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view22: UIView!
    func setDataPro(){
        if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_login_account"){
            for item in 0..<number_user{
                let emailUserKey = "email_login_" + String(item + 1)
                if let emailUser: String = KeychainWrapper.standard.string(forKey: emailUserKey){
                    self.userNameTextField.text = emailUser
                }
                let idPassUser = "pass_login_" + String(item + 1)
                if let passEmail: String = KeychainWrapper.standard.string(forKey: idPassUser){
                    self.passWordTextField.text = passEmail
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let emailUser: String = KeychainWrapper.standard.string(forKey: "email_login_temp"){
            if emailUser != ""{
                self.userNameTextField.text = emailUser
                KeychainWrapper.standard.set("", forKey: "email_login_temp")
                if let passEmail: String = KeychainWrapper.standard.string(forKey: "pass_login_temp"){
                    self.passWordTextField.text = passEmail
                    KeychainWrapper.standard.set("", forKey: "pass_login_temp")
                }
                KeychainWrapper.standard.set("", forKey: "time_login_temp")
            }else{
                setDataPro()
            }
            
        }else{
            setDataPro()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view11.layer.borderWidth = 1
        view11.layer.borderColor = UIColor.gray.cgColor
        view22.layer.borderWidth = 1
        view22.layer.borderColor = UIColor.gray.cgColor
        showPassButton.setTitle("", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "user name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passWordTextField.attributedPlaceholder = NSAttributedString(
            string: "password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        hideKeyboardWhenTappedAround()
//        try? VideoBackground.shared.play(view: imageBackground, videoName: "swap-face", videoType: "mp4")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabelLisAccountLogin(tap:)))
      //  oldLoginLabel.addGestureRecognizer(tap)
      //  oldLoginLabel.isUserInteractionEnabled = true
        
       // settingAttrLabel()
        callApiIP()
        self.errorMessageLabel.text = ""
        //showPasswordButton.setTitle("", for: .normal)
        fbbtn.setTitle("", for: .normal)
        ggbtn.setTitle("", for: .normal)
    }
    
    func callApiIP(){
        RegisterAPI.shared.getIP { result in
            switch result {
            case .success(let success):
                AppConstant.saveIp(model: success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        guard userNameTextField.text != "" && passWordTextField.text != "" else {
            if userNameTextField.text == "" {
                self.view.makeToast("UserName or Email cannot be blank", position: .top)
            } else {
                self.view.makeToast("Password cannot be left blank",position: .top)
            }
             return
        }
        showCustomeIndicator()
        let parameters = ["email_or_username": userNameTextField.text.asStringOrEmpty(), "password": passWordTextField.text.asStringOrEmpty()]
        APIService.shared.LoginAPI(param: parameters){result, error in
            self.hideCustomeIndicator()
            guard result?.id_user != nil else {
                self.view.makeToast(result?.ketqua, position: .top)
                self.errorMessageLabel.text =  "thong tin tai khoan or mk khong dung!"
                if let messagePro = result?.ketqua{
                    self.showAlert(message: messagePro)
                    return
                }
//                self.showAlert(message: (result?.ketqua) ?? "qqqqqPassword Wrong Or Account Not Register Or Account Not Verify Email")
                return
            }
            if let result = result{
                AppConstant.saveUser(model: result)
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_login_account"){
                    let number_userPro = number_user + 1
                    KeychainWrapper.standard.set(number_userPro, forKey: "saved_login_account")
                    if let resultEmail = (result.email){
                        let idUserNumber = "email_login_" + String(number_userPro)
                        KeychainWrapper.standard.set(resultEmail, forKey: idUserNumber)
                        let idPassUser = "pass_login_" + String(number_userPro)
                        KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                        let idTimeUser = "time_login_" + String(number_userPro)
                        let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                        KeychainWrapper.standard.set(timeNow, forKey: idTimeUser)
                    }
                }else{
                    KeychainWrapper.standard.set(1, forKey: "saved_login_account")
                    if let resultEmail = (result.email){
                        let idUserNumber = "email_login_" + String(1)
                        KeychainWrapper.standard.set(resultEmail, forKey: idUserNumber)
                        let idPassUser = "pass_login_" + String(1)
                        KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                        let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                        let idTimeUser = "time_login_" + String(1)
                        KeychainWrapper.standard.set( timeNow, forKey: idTimeUser)
                    }
                }
            }
            let storyboard = UIStoryboard(name: "mainpage", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mhthunhat") as! mhthunhat
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionBtnHiden(_ sender: Any) {
      
        if passWordTextField.isSecureTextEntry == true {
            passWordTextField.isSecureTextEntry = false
        } else {
            passWordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnResetPass(_ sender: Any) {
//        self.navigationController?.pushViewController(FogotPassViewController(nibName: "FogotPassViewController", bundle: nil), animated: true)
    }
    
    func settingAttrLabel() {
//        let attrText = NSMutableAttributedString.getAttributedString(fromString: "Don’t have an account? Register")
//        attrText.apply(color: UIColor(hexString: "FFFFFF"), subString: "Register")
//        registerLabel.attributedText = attrText
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabelProvision(tap:)))
//        registerLabel.addGestureRecognizer(tap)
//        registerLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapLabelLisAccountLogin(tap: UITapGestureRecognizer) {
//        let vc = ListAccountVC(nibName: "ListAccountVC", bundle: nil)
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func tapLabelProvision(tap: UITapGestureRecognizer) {
//        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func register(){
       // AppConstant.userId = nil
        let storyboard = UIStoryboard(name: "login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func SkipLoginAccount(){
        AppConstant.userId = nil
        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mhchinhController") as! mhchinhController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}
