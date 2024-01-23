//
//  SwapVideoDetailVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 11/4/23.
//

import UIKit
import TrailerPlayer
import HGCircularSlider
import Kingfisher
import Vision
import PhotosUI
import AVKit
class newSwapvideo: UIViewController {
    var itemLink:Temple2VideoModel = Temple2VideoModel()
    @IBAction func addVideo(_ sender: Any) {
           addFunc()
       }
    func addFunc() {
            var configuration: PHPickerConfiguration = PHPickerConfiguration()
            configuration.filter = .any(of: [.images, .videos])
            configuration.selectionLimit = 1

            let picker: PHPickerViewController = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    var videoData:Data?
    var videoUrl:URL?
    @IBOutlet weak var buttonBack: UIButton!
    var IsStopBoyAnimation = true
  //  @IBOutlet weak var boyImage: UIImageView!
    var image_Data_Nam:UIImage = UIImage()
    var linkImageVideoSwap:String = ""
  //  @IBOutlet weak var circularSlider: CircularSlider!
  //  @IBOutlet weak var timerLabel: UILabel!
  //  @IBOutlet weak var percentLabel: UILabel!
    let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    @AutoLayout
    private var playerView: TrailerPlayerView = {
        let view = TrailerPlayerView()
        view.enablePictureInPicture = true
        return view
    }()
    private let autoPlay = false
    private let autoReplay = false
    @AutoLayout
    private var controlPanel: ControlPanel = {
        let view = ControlPanel()
        return view
    }()
    
    @AutoLayout
    private var replayPanel: ReplayPanel = {
        let view = ReplayPanel()
        return view
    }()
    
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    @IBAction func nextStep(){
        let vc = newVideo2(nibName: "newVideo2", bundle: nil)
        print("video url.  ")
        print(self.videoUrl)
        print("video url.  ")
        print(self.videoData)
        vc.videoUrl=self.videoUrl
        vc.videoData =  self.videoData
        
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    var timerNow: Timer = Timer()
    func uploadGenVideoByImages(completion: @escaping ApiCompletion){
        APIService.shared.UploadImagesToGenRieng("https://metatechvn.store/upload-gensk/" + String(AppConstant.userId ?? 0) + "?type=src_vid", ImageUpload: self.image_Data_Nam,method: .POST, loading: true){data,error in
            completion(data, nil)
        }
    }

    
    @objc func imageBoyTapped(_ sender: UITapGestureRecognizer) {
        let refreshAlert = UIAlertController(title: "Use Old Images Uploaded", message: "Do You Want Select Old Images For AI Generate Images", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Load Old Images", style: .default, handler: { (action: UIAlertAction!) in
            let vc = ListImageOldVC(nibName: "ListImageOldVC", bundle: nil)
            vc.type = "video"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Upload Image New", style: .cancel, handler: { (action: UIAlertAction!) in
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
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    func updatePlayerUI(withCurrentTime currentTime: CGFloat) {
   
        var components = DateComponents()
        components.second = Int(currentTime)
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        self.buttonBack.setTitle("", for: UIControl.State.normal)
       
        buttonBack.setTitle("", for: .normal)
        view.addSubview(playerView)
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 0.65).isActive = true
        if #available(iOS 11.0, *) {
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        } else {
            playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        }
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageBoyTapped(_:)))
        
        
        controlPanel.delegate = self
        playerView.addControlPanel(controlPanel)
        
        if !autoReplay {
            replayPanel.delegate = self
            playerView.addReplayPanel(replayPanel)
        }
        
        if !autoPlay {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            playerView.manualPlayButton = button
        }
        

    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let enableFullscreen = UIDevice.current.orientation.isLandscape
        controlPanel.fullscreenButton.isSelected = enableFullscreen
        playerView.fullscreen(enabled: enableFullscreen)
    }

}
extension newSwapvideo: TrailerPlayerPlaybackDelegate {
    
    func trailerPlayer(_ player: TrailerPlayer, didUpdatePlaybackTime time: TimeInterval) {
        controlPanel.setProgress(withValue: time, duration: playerView.duration)
    }
    
    func trailerPlayer(_ player: TrailerPlayer, didChangePlaybackStatus status: TrailerPlayerPlaybackStatus) {
        controlPanel.setPlaybackStatus(status)
    }
}

extension newSwapvideo: ControlPanelDelegate {
    
    func controlPanel(_ panel: ControlPanel, didTapMuteButton button: UIButton) {
        playerView.toggleMute()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapPlayPauseButton button: UIButton) {
        if playerView.status == .playing {
            playerView.pause()
        } else {
            playerView.play()
        }
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapFullscreenButton button: UIButton) {
        playerView.fullscreen(enabled: button.isSelected,
                              rotateTo: button.isSelected ? .landscapeRight: .portrait)
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTouchDownProgressSlider slider: UISlider) {
        playerView.pause()
        playerView.cancelAutoFadeOutAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didChangeProgressSliderValue slider: UISlider) {
        playerView.seek(to: TimeInterval(slider.value))
        playerView.play()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
}

extension newSwapvideo: ReplayPanelDelegate {
    
    func replayPanel(_ panel: ReplayPanel, didTapReplayButton: UIButton) {
        playerView.replay()
    }
}

extension newSwapvideo : UIPickerViewDelegate,
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
          //  self.detectFaces(in: selectedImage)
        } else {
            print("Image not found")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension newSwapvideo: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)

        guard let itemProvider = results.first?.itemProvider else { return }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
                    print("Displaying image")
                    DispatchQueue.main.async {
                        //self.imageVieww.image = image
                    }
                }
            }
        } else if itemProvider.hasItemConformingToTypeIdentifier("public.movie") {
            itemProvider.loadFileRepresentation(forTypeIdentifier: "public.movie") { [weak self] (videoURL, error) in
                            if let videoURL = videoURL as? URL {
                                do {
                                    let defaultImageURL = Bundle.main.url(forResource: "download", withExtension: "png")
                                    self?.videoUrl = videoURL
                                    let item = TrailerPlayerItem(
                                        url: self?.videoUrl,
                                        thumbnailUrl: defaultImageURL,
                                        autoPlay: self?.autoPlay ?? true,
                                        autoReplay: self?.autoReplay ?? true)
                                    self?.playerView.playbackDelegate = self
                                    self?.playerView.set(item: item)
                                    //self?.playerView.replay()
                                    self?.videoData = try Data(contentsOf: videoURL)
                                    print("Video Data: \(self?.videoData)")
                                    
                                    // Lưu trữ videoData vào biến hoặc thực hiện các xử lý khác ở đây
                                } catch {
                                    print("Error loading video data: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
    }
    
    func generateThumbnail(for videoURL: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: videoURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true

            let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
            if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
                return UIImage(cgImage: imageRef)
            }
        } catch {
            print("Error generating thumbnail: \(error.localizedDescription)")
        }
        return nil
    }

