//
//  LoveViewController.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit
import SETabView
import Vision
import Toast_Swift
import DeviceKit
import HGCircularSlider
import SwiftKeychainWrapper
import SwiftVideoBackground
import WCLShineButton
import AVFoundation
import Kingfisher
import StoreKit

class LoveViewController: BaseViewController, SETabItemProvider {
    ///_____SONPIPI____
    let defaultDuration = 2.0
    let defaultDamping = 0.20
    let defaultVelocity = 6.0
    var bubbleSound: SystemSoundID!
    var isCheckGirl = true
    var image_Data_Nam:UIImage = UIImage()
    var image_Data_Nu:UIImage = UIImage()
    //____END_SONPIPI____
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_love(), tag: 0)
    }
    var IsStopGirlAnimation = true
    var IsStopBoyAnimation = true
    var currentImageType: ChooseImageType = .boy
    var imageboyLink: String = ""
    var imageGirlLink: String = ""
    @IBOutlet weak var luonSong2Image: UIImageView!
    @IBOutlet weak var luonSongImage: UIImageView!
    @IBOutlet weak var textViewMain: UITextView!
    var timerNow: Timer = Timer()
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addImageBoy: UIImageView!
    @IBOutlet weak var boyImage: UIImageView!
    @IBOutlet weak var girlImage: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var boyNameTextField: UITextField!
    @IBOutlet weak var girlNameTextField: UITextField!
    @IBOutlet weak var buttonLove: UIButton!
    @IBOutlet weak var buttonPrivacy: UIButton!
    @IBOutlet weak var buttonHowTo: UIButton!
    
    @IBOutlet weak var boyView: UIView!
    @IBOutlet weak var girlView: UIView!
    
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //backgroundView.gradient()
    }
    var timer = Timer()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerNow.invalidate()
        timerLabel.text = "0h:00"
        percentLabel.text = "0%"
        self.buttonLove.isEnabled = true
    }
    
    func animateViewAll(viewAnim:UIView){
        viewAnim.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(1),
                       options: .allowUserInteraction,
                       animations: {
            viewAnim.transform = .identity
        },
                       completion: { finished in
            if viewAnim == self.boyView{
                if self.IsStopBoyAnimation == true{
                    return
                }
            }
            if viewAnim == self.girlView{
                if self.IsStopGirlAnimation == true{
                    return
                }
            }
            self.animateViewAll(viewAnim:viewAnim)
        }
        )
    }
    
    func animateButton() {
        buttonLove.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(1),
                       options: .allowUserInteraction,
                       animations: {
            self.buttonLove.transform = .identity
        },
                       completion: { finished in
            self.animateButton()
        }
        )
    }
    
    func createBubbleSound() -> SystemSoundID {
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "bubble" as CFString?, "mp3" as CFString?, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
    
    @objc func Send_OLD_Images_Click(notification: NSNotification) {
        if let imageLink = notification.userInfo?["image"] as? String {
            if self.isCheckGirl == true{
                self.imageGirlLink = imageLink
                let url = URL(string: imageLink)
                let processor = DownsamplingImageProcessor(size: self.girlImage.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
                self.girlImage.kf.indicatorType = .activity
                self.girlImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }else{
                let url = URL(string: imageLink)
                self.imageboyLink = imageLink
                let processor = DownsamplingImageProcessor(size: self.boyImage.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
                self.boyImage.kf.indicatorType = .activity
                self.boyImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "6463770787") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rateApp()
        NotificationCenter.default.addObserver(self, selector: #selector(Send_OLD_Images_Click), name: NSNotification.Name(rawValue: "Notification_SEND_IMAGES"), object: nil)
        bubbleSound = createBubbleSound()
        buttonPrivacy.setTitle("", for: .normal)
        buttonHowTo.setTitle("", for: .normal)
        buttonLove.setTitle("", for: .normal)
        actionImage()
        animateButton()
        boyNameTextField.text = UIDevice.current.name + " Boy"
        girlNameTextField.text = UIDevice.current.name + " Girl"
        let device = Device.current
        let modelName = device.description
        AppConstant.modelName = modelName
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        UIView.animate(withDuration: 2.0, animations: {
            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: 0)
        }) { _ in
            self.luonSongImage.transform = CGAffineTransform(translationX: 0 , y: 0)
        }
        UIView.animate(withDuration: 3.0, animations: {
            self.luonSong2Image.transform = CGAffineTransform(translationX: -160 , y: 0)
        }) { _ in
            self.luonSong2Image.transform = CGAffineTransform(translationX: 0 , y: 0)
        }
        textViewMain.backgroundColor = UIColor.clear
        textViewMain.isEditable = false
        circularSlider.endPointValue = 0
    }
    
    @objc func timerAction() {
        UIView.animate(withDuration: 2.0, animations: {
            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: 0)
        }) { _ in
            self.luonSongImage.transform = CGAffineTransform(translationX: 0 , y: 0)
        }
        UIView.animate(withDuration: 3.0, animations: {
            self.luonSong2Image.transform = CGAffineTransform(translationX: -160 , y: 0)
        }) { _ in
            self.luonSong2Image.transform = CGAffineTransform(translationX: 0 , y: 0)
        }
    }
    
    override func setupUI() {
        hideKeyboardWhenTappedAround()
        addImageBoy.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.4 / 2
        boyImage.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.4 / 2
        girlImage.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.4 / 2
        addImage.layer.cornerRadius = UIScreen.main.bounds.size.width * 0.4 / 2
    }
    
    let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()
    
    func updatePlayerUI(withCurrentTime currentTime: CGFloat) {
        circularSlider.endPointValue = currentTime
        var components = DateComponents()
        components.second = Int(currentTime)
        timerLabel.text = dateComponentsFormatter.string(from: components)
    }
//    @IBAction func PrivacyActionPro(_ sender: Any) {
//        let vc = PrivacyMainVC( )
//        self.navigationController?.pushViewController(vc, animated: false)
//    }
    
    func resizeImage(image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRectMake(0.0, 0.0, CGFloat(actualWidth), CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    @IBAction func startEventBtn(_ sender: Any) {
        
        self.girlImage.image = self.image_Data_Nam
        self.boyImage.image = self.image_Data_Nu
        guard self.boyNameTextField.text != "" && self.girlNameTextField.text != ""  else {
            if self.imageGirlLink == "" {
                self.animateViewAll(viewAnim: self.girlView)
                self.view.makeToast("Please select Photo girl", position: .top)
                self.IsStopGirlAnimation = false
            }else if self.imageboyLink == "" {
                self.animateViewAll(viewAnim: self.boyView)
                self.view.makeToast("Please select Boy girl", position: .top)
                self.IsStopBoyAnimation = false
            } else if self.boyNameTextField.text == "" || self.girlNameTextField.text == "" {
                self.view.makeToast("Please Fill Text Name For Boy And Girl", position: .top)
            }
            return
        }
        try? VideoBackground.shared.play(view: self.backgroundView, videoName: "background2", videoType: "mp4")
        //self.showCustomeIndicator()
        self.circularSlider.maximumValue = 180.0
        var timeCount = 0.0
        self.timerNow = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
            timeCount = timeCount + 1
            let tile = Int((timeCount / 180.0) * 100.0)
            self.percentLabel.text = String(tile) + " %"
            self.updatePlayerUI(withCurrentTime: CGFloat(timeCount))
        }
        self.buttonLove.isEnabled = false
        let OldGirlLink = self.imageGirlLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
        let OldBoyLink = self.imageboyLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
        APIService.shared.getEventsAPI(linkNam: OldBoyLink, linkNu: OldGirlLink,device: AppConstant.modelName ?? "iphone", ip: AppConstant.IPAddress.asStringOrEmpty(), Id: AppConstant.userId.asStringOrEmpty(), tennam: self.boyNameTextField.text.asStringOrEmpty(), tennu: self.girlNameTextField.text.asStringOrEmpty()){ result, error in
            if let success = result{
                self.hideCustomeIndicator()
                if let id_toan_bo_su_kien = Int((success.sukien.first?.id_toan_bo_su_kien ?? "0")){
                    if id_toan_bo_su_kien > 0{
                        self.buttonLove.isEnabled = true
                        let data = id_toan_bo_su_kien
                        let vc = EventViewController(data: data)
                        var dataDetail: [EventModel] = [EventModel]()
                        var sothutu_sukien = 1
                        for indexList in success.sukien{
                            var itemAdd:EventModel = EventModel()
                            itemAdd.link_da_swap = indexList.link_img
                            itemAdd.count_comment = 0
                            itemAdd.count_view = 0
                            itemAdd.id = Int(indexList.id ?? "0")
                            itemAdd.id_user = indexList.id_num
                            let dateNow = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
                            let dateString = dateFormatter.string(from:dateNow)
                            itemAdd.real_time = dateString
                            //                            itemAdd.id_template = indexList.id_template
                            itemAdd.link_nam_chua_swap = indexList.nam
                            itemAdd.link_nu_chua_swap = indexList.nu
                            itemAdd.link_nu_goc = indexList.nam
                            itemAdd.link_nam_goc = indexList.nu
                            itemAdd.noi_dung_su_kien = indexList.thongtin
                            itemAdd.so_thu_tu_su_kien = sothutu_sukien
                            sothutu_sukien = sothutu_sukien + 1
                            //                            itemAdd.phantram_loading = indexList.phantram_loading
                            
                            //                            itemAdd.so_thu_tu_su_kien = indexList.so_thu_tu_su_kien
                            //                            itemAdd.ten_nam = indexList.ten_nam
                            //                            itemAdd.ten_nu = indexList.ten_nu
                            itemAdd.ten_su_kien = indexList.tensukien
                            dataDetail.append(itemAdd)
                        }
                        let idSukienPro = success.sukien[0].id_toan_bo_su_kien ?? "0"
                        vc.idToanBoSuKien = Int(idSukienPro ) ?? 0
                        vc.dataDetail = dataDetail
                        let OldGirlLink = self.imageGirlLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
                        let OldBoyLink = self.imageboyLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
                        APIService.shared.getEventsAPISuKienNgam(linkNam: OldBoyLink, linkNu: OldGirlLink,device: AppConstant.modelName ?? "iphone", ip: AppConstant.IPAddress.asStringOrEmpty(), Id: AppConstant.userId.asStringOrEmpty(), tennam: self.boyNameTextField.text.asStringOrEmpty(), tennu: self.girlNameTextField.text.asStringOrEmpty()){ result, error in
                            if let success = result{
                            }
                        }
                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func LoadHowTo(){
        let vc = HowToUseVC( )
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func actionImage(){
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(imageBoyTapped(_:)))
        boyImage.addGestureRecognizer(tapGesture)
        boyImage.isUserInteractionEnabled = true
        let tapaGesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(imageGirlTapped(_:)))
        girlImage.addGestureRecognizer(tapaGesture)
        girlImage.isUserInteractionEnabled = true
    }
    
    func imageBoySelected(){
        if let retrievedBool: Bool = KeychainWrapper.standard.bool(forKey: "LOAD_IMAGES_HOW_TO"){
            if retrievedBool == true{
                currentImageType = .boy
                var alertStyle = UIAlertController.Style.actionSheet
                if (UIDevice.current.userInterfaceIdiom == .pad) {
                    alertStyle = UIAlertController.Style.alert
                }
                let ac = UIAlertController(title: "Select Image", message: "Select image from", preferredStyle: alertStyle)
                let cameraBtn = UIAlertAction(title: "Camera", style: .default) {_ in
                    self.IsStopBoyAnimation = true
                    self.showImagePicker(selectedSource: .camera)
                }
                let libaryBtn = UIAlertAction(title: "Libary", style: .default) { _ in
                    self.IsStopBoyAnimation = true
                    self.showImagePicker(selectedSource: .photoLibrary)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel){ _ in
                    self.dismiss(animated: true)
                }
                ac.addAction(cameraBtn)
                ac.addAction(libaryBtn)
                ac.addAction(cancel)
                
                self.present(ac, animated: true)
                return
            }
        }
        let vc = HowToUseVC( )
        self.navigationController?.pushViewController(vc, animated: false)
        KeychainWrapper.standard.set(true, forKey: "LOAD_IMAGES_HOW_TO")
    }
    
    @objc func imageBoyTapped(_ sender: UITapGestureRecognizer) {
        self.isCheckGirl = false
        let refreshAlert = UIAlertController(title: "Use Old Images Uploaded", message: "Do You Want Select Old Images For AI Generate Images", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Load Old Images", style: .default, handler: { (action: UIAlertAction!) in
            let vc = ListImageOldVC(nibName: "ListImageOldVC", bundle: nil)
            vc.type = "nam"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Upload Image New", style: .cancel, handler: { (action: UIAlertAction!) in
            self.imageBoySelected()
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func imageGirlSelected(){
        if let retrievedBool: Bool = KeychainWrapper.standard.bool(forKey: "LOAD_IMAGES_HOW_TO"){
            if retrievedBool == true{
                currentImageType = .girl
                var alertStyle = UIAlertController.Style.actionSheet
                if (UIDevice.current.userInterfaceIdiom == .pad) {
                    alertStyle = UIAlertController.Style.alert
                }
                let ac = UIAlertController(title: "Select Image", message: "Select image from", preferredStyle: alertStyle)
                let cameraBtn = UIAlertAction(title: "Camera", style: .default) {_ in
                    self.IsStopGirlAnimation = true
                    self.showImagePicker(selectedSource: .camera)
                }
                let libaryBtn = UIAlertAction(title: "Libary", style: .default) { _ in
                    self.IsStopGirlAnimation = true
                    self.showImagePicker(selectedSource: .photoLibrary)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel){ _ in
                    self.dismiss(animated: true)
                }
                ac.addAction(cameraBtn)
                ac.addAction(libaryBtn)
                ac.addAction(cancel)
                self.present(ac, animated: true)
                return
            }
        }
        let vc = HowToUseVC( )
        self.navigationController?.pushViewController(vc, animated: false)
        KeychainWrapper.standard.set(true, forKey: "LOAD_IMAGES_HOW_TO")
    }
    
    @objc func imageGirlTapped(_ sender: UITapGestureRecognizer) {
        isCheckGirl = true
        let refreshAlert = UIAlertController(title: "Use Old Images Uploaded", message: "Do You Want Select Old Images For AI Generate Images", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Load Old Images", style: .default, handler: { (action: UIAlertAction!) in
            let vc = ListImageOldVC(nibName: "ListImageOldVC", bundle: nil)
            vc.type = "nu"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Upload Image New", style: .cancel, handler: { (action: UIAlertAction!) in
            self.imageGirlSelected()
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func saveLinkImage(linkImg:String){
        if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_link_avatar"){
            let number_userPro = number_user + 1
            KeychainWrapper.standard.set(number_userPro, forKey: "saved_link_avatar")
            let LinkKey = "link_avatar_" + String(number_userPro)
            KeychainWrapper.standard.set(linkImg, forKey: LinkKey)
            let idTimeUser = "time_login_" + String(number_userPro)
            let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
            KeychainWrapper.standard.set(timeNow, forKey: idTimeUser)
        }else{
            KeychainWrapper.standard.set(Int(1), forKey: "saved_link_avatar")
            let LinkKey = "link_avatar_" + String(1)
            KeychainWrapper.standard.set(linkImg, forKey: LinkKey)
            let idTimeUser = "time_login_" + String(1)
            let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
            KeychainWrapper.standard.set(timeNow, forKey: idTimeUser)
        }
    }
    func uploadGenLoveByImages(isNam:Bool,image_Data:UIImage,completion: @escaping ApiCompletion){
        var checkNamNu = ""
        if isNam == true{
            checkNamNu = "?type=src_nam"
        }else{
            checkNamNu = "?type=src_nu"
        }
        APIService.shared.UploadImagesToGenRieng("https://databaseswap.mangasocial.online/upload-gensk/" + String(AppConstant.userId ?? 0) + checkNamNu, ImageUpload: image_Data,method: .POST, loading: true){data,error in
            completion(data, nil)
        }
    }
    func detectFaces(in image: UIImage)  {
        //        if let cgImage = image.cgImage {
        //            let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up, options: [:])
        //            do {
        //                let faceDetectionRequest = VNDetectFaceRectanglesRequest()
        //                try requestHandler.perform([faceDetectionRequest])
        //                if let results = faceDetectionRequest.results {
        //                    if results.count == 1 {
        if self.currentImageType == .boy {
            self.boyImage.image = UIImage(named: "icon-upload")
            self.uploadGenLoveByImages(isNam: true, image_Data: image){data,error in
                if let data = data as? String{
                    let OldBoyLink = data.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online", options: .literal, range: nil)
                    self.imageGirlLink = OldBoyLink
                    self.image_Data_Nam = image
                }
            }
        }else{
            self.girlImage.image = UIImage(named: "icon-upload")
            self.uploadGenLoveByImages(isNam: false, image_Data: image){data,error in
                if let data = data as? String{
                    let OldGirlLink = data.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online", options: .literal, range: nil)
                    self.imageGirlLink = OldGirlLink
                    self.image_Data_Nu = image
                }
            }
            self.image_Data_Nu = image
        }
        //                    }else{
        //                        let textAlertFace = "Image Have " + String( results.count ) + " Face - You need to choose a photo with only one face"
        //                        self.showAlert(message: textAlertFace)
        //                    }
        //                }
        
        //            }catch {
        //                print("Error: \(error)")
        //            }
        //        }
    }
    
}

extension LoveViewController : UIPickerViewDelegate,
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
            if self.currentImageType == .boy {
                picker.dismiss(animated: true)
                self.detectFaces(in: selectedImage)
            } else {
                picker.dismiss(animated: true)
                self.detectFaces(in: selectedImage)
            }
        } else {
            print("Image not found")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension LoveViewController : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        textField.resignFirstResponder()
        return true
    }
}

enum ChooseImageType {
    case boy
    case girl
}
