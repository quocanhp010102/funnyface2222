//
//  babycenter.swift
//  funnyface2222
//
//  Created by quocanhppp on 21/02/2024.
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
class babycenter: BaseViewController {
    
    var fullscreenView: UIView?
    var initialImageScale: CGFloat = 1.0
    var linkanhgocw:String = ""
    var bubbleSound: SystemSoundID!
    var isCheckGirl = true
    var image_Data_Nam:UIImage = UIImage()
    var image_Data_Nu:UIImage = UIImage()
    var downloadButton: UIButton?
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_love(), tag: 0)
    }
    var IsStopGirlAnimation = true
    var IsStopBoyAnimation = true
    var currentImageType: ChooseImageType2 = .boy
    var imageboyLink: String = ""
    var imageGirlLink: String = ""
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var addImageBoy: UIImageView!
    @IBOutlet weak var boyImage: UIImageView!
    @IBOutlet weak var girlImage: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var boyNameTextField: UITextField!
    @IBOutlet weak var girlNameTextField: UITextField!
    @IBOutlet weak var buttonLove: UIButton!
    @IBOutlet weak var buttonKQ: UIButton!
    @IBOutlet weak var boyView: UIView!
    @IBOutlet weak var girlView: UIView!
    @IBOutlet weak var imageBaby: UIImageView!
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
    @objc func panTapPro(sender: UIPanGestureRecognizer){
        let tranlation = sender.translation(in: view)
        if sender.state == .changed {
            if let linkWebImage = sender.view {
                linkWebImage.center.x += tranlation.x
                linkWebImage.center.y += tranlation.y
                sender.setTranslation(CGPoint.zero, in: view)
            }
        }
    }
    @objc func closeButtonTapped() {
        // Đóng ảnh phóng to
        dismissFullscreenImage()
    }
    func dismissFullscreenImage() {
        UIView.animate(withDuration: 0.3, animations: {
            self.fullscreenView?.alpha = 0
        }) { _ in
            self.fullscreenView?.removeFromSuperview()
            self.fullscreenView = nil
        }
    }
    @objc func pinchGestureHandler(sender: UIPinchGestureRecognizer){
        if sender.state == .began {
            initialImageScale = fullscreenView!.transform.a
        }
        if sender.state == .changed {
            let scale = sender.scale
            let scaledValue = max(min(initialImageScale * scale, 2.0), initialImageScale)
            fullscreenView?.transform = CGAffineTransform(scaleX: scaledValue, y: scaledValue)
        }
        
        if sender.state == .ended {
            fullscreenView?.transform = CGAffineTransform(scaleX: initialImageScale, y: initialImageScale)
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error Saved Images: \(error.localizedDescription)")
        } else {
            print("Download Images Done Okie")
        }
    }
    @objc func downloadButtonTapped() {
        let alert = UIAlertController(title: "Download", message: "Save For Images Library", preferredStyle: .alert)
        let oke = UIAlertAction(title: "Oke", style: .default) { result in
            if let image = self.imageBaby.image {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            self.view.makeToast("Download Done")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(oke)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    @objc func tapAnhNam(sender: UITapGestureRecognizer) {
        fullscreenView = UIView(frame: view.bounds)
        fullscreenView?.backgroundColor = .black
        fullscreenView?.alpha = 0
        
        var zoomedImageView = UIImageView(frame: self.view.frame)
        zoomedImageView.contentMode = .scaleAspectFit
        
        fullscreenView?.addSubview(zoomedImageView)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler))
        fullscreenView?.addGestureRecognizer(pinchGesture)
        downloadButton = UIButton(type: .custom)
        downloadButton?.setTitle("Download", for: .normal)
        downloadButton?.frame = CGRect(x: 20, y: 50, width: 100, height: 40)
        downloadButton?.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        fullscreenView?.addSubview(downloadButton!)
        let url = URL(string: self.linkanhgocw )
        let processor = DownsamplingImageProcessor(size: zoomedImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        zoomedImageView.kf.indicatorType = .activity
        zoomedImageView.kf.setImage(
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
                
        let closeButton = UIButton(frame: CGRect(x: view.bounds.width - 120, y: 50, width: 100, height: 40))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        fullscreenView?.addSubview(closeButton)
        
        if let fullscreenView = fullscreenView {
            view.addSubview(fullscreenView)
        }
        
        
        UIView.animate(withDuration: 0.3) {
            self.fullscreenView?.alpha = 1
            zoomedImageView.frame = UIScreen.main.bounds
        }
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
//        bubbleSound = createBubbleSound()
      //  buttonPrivacy.setTitle("", for: .normal)
       // buttonHowTo.setTitle("", for: .normal)
        buttonLove.setTitle("", for: .normal)
        actionImage()
        animateButton()
        boyNameTextField.text = UIDevice.current.name + " Boy"
        girlNameTextField.text = UIDevice.current.name + " Girl"
        let device = Device.current
        let modelName = device.description
        AppConstant.modelName = modelName
        let clickImageNu = UIPanGestureRecognizer(target: self, action: #selector(panTapPro))
        self.buttonKQ.addGestureRecognizer(clickImageNu)
        let tapNu = UITapGestureRecognizer(target: self, action: #selector(tapAnhNam))
        self.buttonKQ.addGestureRecognizer(tapNu)
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//        UIView.animate(withDuration: 2.0, animations: {
//            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: 0)
//        }) { _ in
//            self.luonSongImage.transform = CGAffineTransform(translationX: 0 , y: 0)
//        }
//        UIView.animate(withDuration: 3.0, animations: {
//            self.luonSong2Image.transform = CGAffineTransform(translationX: -160 , y: 0)
//        }) { _ in
//            self.luonSong2Image.transform = CGAffineTransform(translationX: 0 , y: 0)
//        }
//        textViewMain.backgroundColor = UIColor.clear
//        textViewMain.isEditable = false
//        circularSlider.endPointValue = 0
        // Do any additional setup after loading the view.
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
    
//    func updatePlayerUI(withCurrentTime currentTime: CGFloat) {
//        circularSlider.endPointValue = currentTime
//        var components = DateComponents()
//        components.second = Int(currentTime)
//        timerLabel.text = dateComponentsFormatter.string(from: components)
//    }
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
        
//        self.girlImage.image = self.image_Data_Nam
//        self.boyImage.image = self.image_Data_Nu
//        guard self.boyNameTextField.text != "" && self.girlNameTextField.text != ""  else {
//            if self.imageGirlLink == "" {
//              //  self.animateViewAll(viewAnim: self.girlView)
//                self.view.makeToast("Please select Photo girl", position: .top)
//                self.IsStopGirlAnimation = false
//            }else if self.imageboyLink == "" {
//               // self.animateViewAll(viewAnim: self.boyView)
//                self.view.makeToast("Please select Boy girl", position: .top)
//                self.IsStopBoyAnimation = false
//            } else if self.boyNameTextField.text == "" || self.girlNameTextField.text == "" {
//                self.view.makeToast("Please Fill Text Name For Boy And Girl", position: .top)
//            }
//            return
//        }
////        try? VideoBackground.shared.play(view: self.backgroundView, videoName: "background2", videoType: "mp4")
////        //self.showCustomeIndicator()
////        self.circularSlider.maximumValue = 180.0
////        var timeCount = 0.0
////        self.timerNow = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (_) in
////            timeCount = timeCount + 1
////            let tile = Int((timeCount / 180.0) * 100.0)
////            self.percentLabel.text = String(tile) + " %"
////            self.updatePlayerUI(withCurrentTime: CGFloat(timeCount))
////        }
//        self.buttonLove.isEnabled = false
        let OldGirlLink = self.imageGirlLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
        let OldBoyLink = self.imageboyLink.replacingOccurrences(of: "https://futurelove.online", with: "/var/www/build_futurelove", options: .literal, range: nil)
       
        APIService.shared.GenBaby(device_them_su_kien: AppConstant.modelName ?? "iphone" , ip_them_su_kien: AppConstant.IPAddress.asStringOrEmpty(), id_user: Int(AppConstant.userId.asStringOrEmpty()) ?? 0, linknam:OldBoyLink , linknu: OldGirlLink){response,error in
            if let response = response{
                print("respon sss ")
                print(response)
                self.linkanhgocw = response.link_da_swap!
                let url = URL(string: response.link_da_swap!)
                let processor = DownsamplingImageProcessor(size: self.imageBaby.bounds.size)
                             |> RoundCornerImageProcessor(cornerRadius: 20)
                self.imageBaby.kf.indicatorType = .activity
                self.imageBaby.kf.setImage(
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
                
//                let vc = DetailSwapVideoVC(nibName: "DetailSwapVideoVC", bundle: nil)
//                vc.itemDataSend = response
//                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//                self.present(vc, animated: true, completion: nil)
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

extension babycenter : UIPickerViewDelegate,
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

extension babycenter : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        textField.resignFirstResponder()
        return true
    }
}

enum ChooseImageType2 {
    case boy
    case girl
}
