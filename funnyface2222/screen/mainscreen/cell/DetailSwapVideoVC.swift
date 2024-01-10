//
//  DetailSwapVideoVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 11/15/23.
//

import UIKit
import TrailerPlayer
import Kingfisher
import Photos

class DetailSwapVideoVC: UIViewController {
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonDownloadSwap: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageUserAvatar: UIImageView!
    
    var buttonDownloadGoc: UIButton!
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
    //___________________________________________________________
    @AutoLayout
    private var playerGocView: TrailerPlayerView = {
        let view = TrailerPlayerView()
        view.enablePictureInPicture = true
        return view
    }()
    private let autoGocPlay = false
    private let autoGocReplay = false
    @AutoLayout
    private var controlGocPanel: ControlPanel = {
        let view = ControlPanel()
        return view
    }()
    
    @AutoLayout
    private var replayGocPanel: ReplayPanel = {
        let view = ReplayPanel()
        return view
    }()
    
    //___________________________________________________________
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    //https://futurelove.online/detailVideo/526729753548
    @IBAction func shareLinkVideoSwap(){
        var linkUrlShare = "https://futurelove.online/detailVideo/" + String(itemDataSend.id_sukien_video ?? "")

        if let urlStr = NSURL(string: linkUrlShare) {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
        
//        let activityVC = UIActivityViewController(activityItems: [linkUrlShare], applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = self.view
//        present(activityVC, animated: true, completion: nil)
//        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
//            if completed  {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
    }
    
    @IBAction func DownloadVideoSwap(){
        if let urlString = self.itemDataSend.link_vid_swap{
            let url = URL(string: urlString)
            DispatchQueue.main.async {
                FileDownloader.loadFileAsync(url: url!) { (path, error) in
                    print("Video Downloaded : \(path!)")
                    DispatchQueue.main.async {
                        let filePathURLVideo = URL(fileURLWithPath: path!)
                        PHPhotoLibrary.requestAuthorization { status in
                            // Return if unauthorized
                            guard status == .authorized else {
                                print("Error saving video: unauthorized access")
                                return
                            }
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: filePathURLVideo as URL)
                            }) { success, error in
                                if !success {
                                    print("Error saving video: \(String(describing: error))")
                                }else{
                                    let alert = UIAlertController(title: "Alert", message: "Download Video Swap Done", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Check Photo Library", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("default")
                                        case .cancel:
                                            print("cancel")
                                        case .destructive:
                                            print("destructive")
                                        }
                                    }))
                                    DispatchQueue.main.async {
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    var itemDataSend:DetailVideoModel = DetailVideoModel()
    
    @objc func tabForViewProfile(sender:UITapGestureRecognizer) {
        print("tap working")
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.userId = itemDataSend.idUser ?? 0
        present(vc, animated: true, completion: nil)
    }
    
    func callApiProfile(userId:Int) {
        APIService.shared.getProfile(user: userId ) { result, error in
            if let success = result {
                self.labelUserName.text = success.user_name
                let escapedString = success.link_avatar?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                if let url = URL(string: escapedString ?? "") {
                    let processor = DownsamplingImageProcessor(size: self.imageUserAvatar.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 5)
                    self.imageUserAvatar.kf.indicatorType = .activity
                    self.imageUserAvatar.kf.setImage(
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapProfile = UITapGestureRecognizer(target: self, action: #selector(self.tabForViewProfile))
        labelUserName.isUserInteractionEnabled = true
        labelUserName.addGestureRecognizer(tapProfile)
        let tapProfile2 = UITapGestureRecognizer(target: self, action: #selector(self.tabForViewProfile))
        imageUserAvatar.isUserInteractionEnabled = true
        imageUserAvatar.addGestureRecognizer(tapProfile2)
        
        self.callApiProfile(userId: itemDataSend.idUser ?? 0)
        self.buttonShare.setTitle("", for: UIControl.State.normal)
        self.buttonDownloadSwap.setTitle("", for: UIControl.State.normal)
        self.buttonBack.setTitle("", for: UIControl.State.normal)
        view.addSubview(playerView)
        let processor = DownsamplingImageProcessor(size: imageViewCover.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 0)
        imageViewCover.kf.setImage(
            with: URL(string: itemDataSend.linkimg ?? ""),
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
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 0.65).isActive = true
        if #available(iOS 11.0, *) {
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170).isActive = true
        } else {
            playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        }
        //______SONPIPI_____
        //        var buttonDownloadSwap: UIButton!
        //        buttonDownloadSwap = UIButton()
        //        buttonDownloadSwap.tintColor = .white
        //        buttonDownloadSwap.setImage(UIImage(named: "downloadbutton-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
        //        buttonDownloadSwap.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        buttonDownloadSwap.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -10).isActive = true
        controlPanel.delegate = self
        playerView.addControlPanel(controlPanel)
        if !autoReplay {
            replayPanel.delegate = self
            playerView.addReplayPanel(replayPanel)
        }
        if !autoPlay {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(named: "play-100")?.withRenderingMode(.alwaysTemplate), for: .normal)
            playerView.manualPlayButton = button
        }
        let item = TrailerPlayerItem(
            url: URL(string: itemDataSend.link_vid_swap ?? ""),
            thumbnailUrl: URL(string: itemDataSend.linkimg ?? ""),
            autoPlay: autoPlay,
            autoReplay: autoReplay)
        playerView.playbackDelegate = self
        playerView.set(item: item)
        //_______________________________________________________
        view.addSubview(playerGocView)
        playerGocView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerGocView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerGocView.heightAnchor.constraint(equalTo: playerGocView.widthAnchor, multiplier: 0.65).isActive = true
        if #available(iOS 11.0, *) {
            playerGocView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
        } else {
            playerGocView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        }
        controlGocPanel.delegate = self
        playerGocView.addControlPanel(controlGocPanel)
        if !autoGocReplay {
            replayGocPanel.delegate = self
            playerGocView.addReplayPanel(replayGocPanel)
        }
        if !autoGocPlay {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(named: "play-100")?.withRenderingMode(.alwaysTemplate), for: .normal)
            playerGocView.manualPlayButton = button
        }
        let itemGoc = TrailerPlayerItem(
            url: URL(string: itemDataSend.link_vid_goc ?? ""),
            thumbnailUrl: URL(string: "https://github.com/sonnh7289/python3-download/blob/main/oldvideologo.jpeg?raw=true"),
            autoPlay: autoPlay,
            autoReplay: autoReplay)
        playerGocView.playbackDelegate = self
        playerGocView.set(item: itemGoc)
    }
}

extension DetailSwapVideoVC: TrailerPlayerPlaybackDelegate {
    
    func trailerPlayer(_ player: TrailerPlayer, didUpdatePlaybackTime time: TimeInterval) {
        if player == playerView.player{
            controlPanel.setProgress(withValue: time, duration: playerView.duration)
        }
        if player == playerGocView.player{
            controlGocPanel.setProgress(withValue: time, duration: playerView.duration)
        }
    }
    
    func trailerPlayer(_ player: TrailerPlayer, didChangePlaybackStatus status: TrailerPlayerPlaybackStatus) {
        if player == playerView.player{
            controlPanel.setPlaybackStatus(status)
        }
        if player == playerGocView.player{
            controlGocPanel.setPlaybackStatus(status)
        }
        
    }
}

extension DetailSwapVideoVC: ControlPanelDelegate {
    
    func controlPanel(_ panel: ControlPanel, didTapMuteButton button: UIButton) {
        if panel == self.controlPanel{
            playerView.toggleMute()
            playerView.autoFadeOutControlPanelWithAnimation()
        }
        if panel == self.controlGocPanel{
            playerGocView.toggleMute()
            playerGocView.autoFadeOutControlPanelWithAnimation()
        }
    }
    
    func controlPanel(_ panel: ControlPanel, didTapPlayPauseButton button: UIButton) {
        if panel == self.controlPanel{
            if playerView.status == .playing {
                playerView.pause()
            } else {
                playerView.play()
            }
            playerView.autoFadeOutControlPanelWithAnimation()
        }
        if panel == self.controlGocPanel{
            if playerGocView.status == .playing {
                playerGocView.pause()
            } else {
                playerGocView.play()
            }
            playerGocView.autoFadeOutControlPanelWithAnimation()
        }
    }
    
    func controlPanel(_ panel: ControlPanel, didTapFullscreenButton button: UIButton) {
        if panel == self.controlGocPanel{
            playerGocView.fullscreen(enabled: button.isSelected,
                                     rotateTo: button.isSelected ? .landscapeRight: .portrait)
            playerGocView.autoFadeOutControlPanelWithAnimation()
        }
        if panel == self.controlPanel{
            playerView.fullscreen(enabled: button.isSelected,
                                  rotateTo: button.isSelected ? .landscapeRight: .portrait)
            playerView.autoFadeOutControlPanelWithAnimation()
        }
    }
    
    func controlPanel(_ panel: ControlPanel, didTouchDownProgressSlider slider: UISlider) {
        if panel == self.controlPanel{
            playerView.pause()
            playerView.cancelAutoFadeOutAnimation()
        }
        if panel == self.controlGocPanel{
            playerGocView.pause()
            playerGocView.cancelAutoFadeOutAnimation()
        }
    }
    
    func controlPanel(_ panel: ControlPanel, didChangeProgressSliderValue slider: UISlider) {
        if panel == self.controlPanel{
            playerView.seek(to: TimeInterval(slider.value))
            playerView.play()
            playerView.autoFadeOutControlPanelWithAnimation()
        }
        if panel == self.controlGocPanel{
            playerGocView.seek(to: TimeInterval(slider.value))
            playerGocView.play()
            playerGocView.autoFadeOutControlPanelWithAnimation()
        }
    }
}

extension DetailSwapVideoVC: ReplayPanelDelegate {
    
    func replayPanel(_ panel: ReplayPanel, didTapReplayButton: UIButton) {
        if panel == self.controlPanel{
            playerView.replay()
        }
        if panel == self.controlGocPanel{
            playerGocView.replay()
        }
    }
}
