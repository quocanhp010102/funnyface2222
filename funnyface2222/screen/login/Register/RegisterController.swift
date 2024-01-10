//
//  RegisterController.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 05/01/2024.
//

//
//  RegisterViewController.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit
import Toast_Swift
import Vision
import SwiftKeychainWrapper
import SwiftVideoBackground

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

class RegisterController: UIViewController {
    var linkImage: String = ""
    @IBOutlet weak var avatarImage: UIButton!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var AgainSHowPass: UIButton!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view22: UIView!
    @IBOutlet weak var view33: UIView!
    @IBOutlet weak var view44: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var isStopAnimation = false
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var errorUserName: UIView!
    @IBOutlet weak var errorEmail: UIView!
    @IBOutlet weak var errorPassword: UIView!
    @IBOutlet weak var errorConfirmPass: UIView!
    @IBOutlet weak var fbbtn: UIButton!
    @IBOutlet weak var ggbtn: UIButton!
    var isError = 0
    
    func animateButton() {
        avatarImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1,
        delay: 0,
                     usingSpringWithDamping: CGFloat(0.3),
                     initialSpringVelocity: CGFloat(0.3),
        options: .allowUserInteraction,
        animations: {
          self.avatarImage.transform = .identity
        },
        completion: { finished in
            if self.isStopAnimation == true{
                return
            }
          self.animateButton()
        }
      )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isStopAnimation = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view11.layer.borderWidth = 1
        view11.layer.borderColor = UIColor.gray.cgColor
        view22.layer.borderWidth = 1
        view22.layer.borderColor = UIColor.gray.cgColor
        view33.layer.borderWidth = 1
        view33.layer.borderColor = UIColor.gray.cgColor
        view44.layer.borderWidth = 1
        view44.layer.borderColor = UIColor.gray.cgColor
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "user name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "email....",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passWordTextField.attributedPlaceholder = NSAttributedString(
            string: "password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "pass word again",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        hideKeyboardWhenTappedAround()
        //settingAttrLabel()
        checkValidate()
        actionImage()
        animateButton()
        avatarImage.setTitle("", for: .normal)
        AgainSHowPass.setTitle("", for: .normal)
        showPassButton.setTitle("", for: .normal)
        fbbtn.setTitle("", for: .normal)
        ggbtn.setTitle("", for: .normal)
//        try? VideoBackground.shared.play(view: imageBackground, videoName: "changeface", videoType: "mp4")
    }
    @IBAction func loginnn(){
       
        let storyboard = UIStoryboard(name: "login", bundle: nil) // type storyboard name instead of Main
         if let myViewController = storyboard.instantiateViewController(withIdentifier: "loginView") as? loginView {
               present(myViewController, animated: true, completion: nil)
         }
//        let storyboard = UIStoryboard(name: "login", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "loginView") as! loginView
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionBtnRegister(_ sender: UIButton) {
        print("hellooooo")
        guard  linkImage != "" else {
            self.showAlert(message: "You have not selected an Avatar image, Please click + button images")
            return self.view.makeToast("You have not selected an Avatar image, Please click + button images")
        }
        showCustomeIndicator()
        let parameter = ["email":emailTextField.text.asStringOrEmpty(), "password": passWordTextField.text.asStringOrEmpty(),"user_name": userNameTextField.text.asStringOrEmpty(), "link_avatar": linkImage, "ip_register": AppConstant.IPAddress.asStringOrEmpty(), "device_register": AppConstant.modelName.asStringOrEmpty()]
        APIService.shared.RegisterAccount(param: parameter) { result, error in
            if let result = result{
                self.hideCustomeIndicator()
                self.isError  = 0
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_login_account"){
                    let number_userPro = number_user + 1
                    KeychainWrapper.standard.set(number_userPro, forKey: "saved_login_account")
                    let idUserNumber = "email_login_" + String(number_userPro)
                    KeychainWrapper.standard.set(self.emailTextField.text.asStringOrEmpty(), forKey: idUserNumber)
                    let idPassUser = "pass_login_" + String(number_userPro)
                    KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                    let idTimeUser = "time_login_" + String(1)
                    let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                    KeychainWrapper.standard.set( timeNow, forKey: idTimeUser)
                }else{
                    KeychainWrapper.standard.set(1, forKey: "saved_login_account")
                    let idUserNumber = "email_login_" + String(1)
                    KeychainWrapper.standard.set(self.emailTextField.text.asStringOrEmpty(), forKey: idUserNumber)
                    let idPassUser = "pass_login_" + String(1)
                    KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                    let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                    let idTimeUser = "time_login_" + String(1)
                    KeychainWrapper.standard.set( timeNow, forKey: idTimeUser)
                }
                self.showAlert(message: result.message ?? "")
            }else{
                if self.isError > 3{
                    self.showAlert(message: "Unknow Error In Server")
                    self.hideCustomeIndicator()
                }
                self.isError =  self.isError + 1
            }
        }
    }
    // MARK: - Validate
    
    @IBAction func changeUserName(_ sender: Any) {
        checkValidate()
    }
    
    @IBAction func changeEmail(_ sender: Any) {
        checkValidate()
    }
    
    @IBAction func changePassword(_ sender: Any) {
        checkValidate()
    }
    
    @IBAction func changeConfirmPass(_ sender: Any) {
        checkValidate()
    }
    
    private  func checkValidate() {
        let email = emailTextField.text.asStringOrEmpty()
        let password = passWordTextField.text.asStringOrEmpty()
        let confirmPassword = confirmPasswordTextField.text.asStringOrEmpty()
        let userName = userNameTextField.text.asStringOrEmpty()
        
        var isEmail: Bool = false
        var isPassword: Bool = false
        var isConfirmPassword: Bool = false
        var isUserName: Bool = false
        isUserName = true

//        if userName.isUserName {
//            isUserName = true
//        } else {
//            isUserName = false
//        }
        
        if email.isValidEmail {
            isEmail = true
        } else {
            isEmail = false
        }
        
        if password.isValidPassword {
            isPassword = true
        } else {
            isPassword = false
        }
        
        if password != confirmPassword {
            isConfirmPassword = false
        } else {
            isConfirmPassword = true
        }
        
        if !isUserName && !userName.isEmpty {
            errorUserName.isHidden = false
        } else {
            errorUserName.isHidden = true
        }
        
        if !isEmail && !email.isEmpty {
            errorEmail.isHidden = false
        } else {
            errorEmail.isHidden = true
        }
        
        if !isPassword && !password.isEmpty {
            errorPassword.isHidden = false
        } else {
            errorPassword.isHidden = true
        }
        
        if !isConfirmPassword && !confirmPassword.isEmpty {
            errorConfirmPass.isHidden = false
        } else {
            errorConfirmPass.isHidden = true
        }
        
        
    }
    // MARK: - CustomAttrLabel
    func settingAttrLabel() {
        let attrText = NSMutableAttributedString.getAttributedString(fromString: "Already have an account? Login")
        attrText.apply(color: UIColor.red, subString: "Login")
        loginLabel?.attributedText = attrText
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabelProvision(tap:)))
        loginLabel?.addGestureRecognizer(tap)
        loginLabel?.isUserInteractionEnabled = true
        
    }
    
    @objc func tapLabelProvision(tap: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBtnHiden(_ sender: Any) {
        if passWordTextField.isSecureTextEntry == true {
            passWordTextField.isSecureTextEntry = false
        } else {
            passWordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func actionBtnHiden2(_ sender: Any) {
        if confirmPasswordTextField.isSecureTextEntry == true {
            confirmPasswordTextField.isSecureTextEntry = false
        } else {
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    // MARK: - ChangeImage
    func actionImage(){
//        let tapGesture = UITapGestureRecognizer(target: self,
//                                                action: #selector(imageAvatarTapped(_:)))
//        avatarImage.addGestureRecognizer(tapGesture)
//        avatarImage.isUserInteractionEnabled = true
        
        
    }
    @IBAction func AvatarTapped(){
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        let ac = UIAlertController(title: "Select Image", message: "Select image from", preferredStyle: alertStyle)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) {_ in
            self.showImagePicker(selectedSource: .camera)
        }
        let libaryBtn = UIAlertAction(title: "Libary", style: .default) { _ in
            self.showImagePicker(selectedSource: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ _ in
            self.dismiss(animated: true)
        }
        
        ac.addAction(cameraBtn)
        ac.addAction(libaryBtn)
        ac.addAction(cancel)
        self.present(ac, animated: true)
    }
    @objc func imageAvatarTapped(_ sender: UITapGestureRecognizer) {
        
        
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension RegisterController : UIPickerViewDelegate,
                                   UINavigationControllerDelegate,
                                   UIImagePickerControllerDelegate {
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true)
            APIService.shared.getAll_KeyAPI( ){response,error in
                let numberItem = response.count
                if numberItem > 0{
                    let randomInt = Int.random(in: 0..<(numberItem - 1))
                    let keyAPI = response[randomInt].APIKey
                    self.avatarImage.setImage(UIImage(named: "icon-upload") , for: .normal)
                    guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
                        return
                    }
                    HomeAPI.shared.uploadImage(key: keyAPI ?? "a07b4b5e0548a50248aecfb194645bac",
                                               name: "image",
                                               view:self.view ,
                                               imageData: imageData) { result in
                        switch result {
                        case .success(let success):
                            self.isStopAnimation =  true
                            self.linkImage = success.data?.url ?? ""
                            self.avatarImage.imageView?.contentMode = UIView.ContentMode.redraw
                            if let imageData = selectedImage.pngData(){
                                let options = [
                                    kCGImageSourceCreateThumbnailWithTransform: true,
                                    kCGImageSourceCreateThumbnailFromImageAlways: true,
                                    kCGImageSourceThumbnailMaxPixelSize: 100] as CFDictionary // Specify your desired size at kCGImageSourceThumbnailMaxPixelSize. I've specified 100 as per your question
                                imageData.withUnsafeBytes { ptr in
                                   guard let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                                      return
                                   }
                                   if let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count){
                                      let source = CGImageSourceCreateWithData(cfData, nil)!
                                      let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
                                      let thumbnail = UIImage(cgImage: imageReference) // You get your thumbail here
                                       self.avatarImage.setImage(thumbnail, for: .normal)
                                   }
                                }
                            }
                      

//                            self.avatarImage.image = selectedImage
                            self.registerBtn.isUserInteractionEnabled = true
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            }
        } else {
            print("Image not found")
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
//extension UIColor {
//    convenience init?(hexString: String) {
//        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
//        formattedString = formattedString.replacingOccurrences(of: "#", with: "")
//
//        var rgb: UInt64 = 0
//        Scanner(string: formattedString).scanHexInt64(&rgb)
//
//        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(rgb & 0x0000FF) / 255.0
//
//        self.init(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//}
