//
//  EventViewController.swift
//  FutureLove
//
//  Created by TTH on 28/07/2023.
//

import UIKit
import AlamofireImage
import Kingfisher

class EventViewController: BaseViewController {
    //___SONPIPI
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonNextSearch: UIButton!
    @IBOutlet weak var buttonBack: UIButton!

    var timeEnd : Date?
    var header : HeaderView?
    //____END_SONPIPI__
    var data : Int
    var dataDetail: [EventModel] = []
    var idToanBoSuKien = 0
    var bIsNam = false
    var userName = ""
    var LinkProfile = ""
    @objc func tapToBack() {
        navigationController?.popViewController(animated: true)
    }
    var backButton: UIButton = {
          let btn = UIButton(frame: CGRect(x:10, y: 30,width : Int(40), height : 40))
          btn.setImage(UIImage(named: "backbutton"), for: .normal)
          btn.addTarget(self, action: #selector(tapToBack), for: .touchUpInside)
          return btn
      }()
    func callApiProfile() {
        APIService.shared.getProfile(user: dataDetail[0].id_user ?? 0) { result, error in
            if let success = result {
                self.userName = success.user_name ?? ""
                self.LinkProfile =  success.link_avatar.asStringOrNilText()
                self.detailTableView.reloadData()
            }
        }
    }
    //______SONPIPI_____
    func addTimerView(){
        var height = 170
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            height = 170
        case .pad:
            height = 250
        @unknown default:
            height = 250
        }
        header = HeaderView(frame: CGRect(x:0, y: 0,width : Int(UIScreen.main.bounds.width+50), height : height))
        header?.addSubview(backButton)
        self.view.addSubview(header!)
        updateView()
    }
    
    func updateView() {
        setTimeLeft()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setTimeLeft), userInfo: nil, repeats: true)
    }
    
    @objc func setTimeLeft() {
        let timeNow = Date()
        if timeEnd?.compare(timeNow) == ComparisonResult.orderedAscending {
            let interval = timeEnd?.timeIntervalSince(timeNow)
            let days =  (-interval! / (60*60*24)).rounded(.down)
            let daysRemainder = -interval!.truncatingRemainder(dividingBy: 60*60*24)
            let hours = (daysRemainder / (60 * 60)).rounded(.down)
            let hoursRemainder = daysRemainder.truncatingRemainder(dividingBy: 60 * 60).rounded(.down)
            let minites  = (hoursRemainder / 60).rounded(.down)
            let minitesRemainder = hoursRemainder.truncatingRemainder(dividingBy: 60).rounded(.down)
            let scondes = minitesRemainder.truncatingRemainder(dividingBy: 60).rounded(.down)
            header?.DaysProgress.setProgress(days/360, animated: false)
            header?.hoursProgress.setProgress(hours/24, animated: false)
            header?.minitesProgress.setProgress(minites/60, animated: false)
            header?.secondesProgress.setProgress(scondes/60, animated: false)
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 2
            header?.valueDay.text = formatter.string(from: NSNumber(value:days))
            header?.valueHour.text = formatter.string(from: NSNumber(value:hours))
            header?.valueMinites.text = formatter.string(from: NSNumber(value:minites))
            header?.valueSeconds.text = formatter.string(from: NSNumber(value:scondes))
        } else {
            header?.fadeOut()
        }
    }
    ///____END_SONPIPI____
    @IBOutlet weak var linkWebImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var keyboardScrollView: UIScrollView!
    init(data: Int) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    @IBAction func BackApp(){
        navigationController?.popViewController(animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundView.gradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBack.setTitle("", for: .normal)
        buttonSearch.setTitle("", for: .normal)
        buttonNextSearch.setTitle("", for: .normal)
        setupUI()
        if dataDetail.count > 0{
            callApiProfile()
            print(dataDetail[0].real_time)
            timeEnd = Date(timeInterval: dataDetail[0].real_time?.toDate(format: "yyyy-MM-dd, HH:mm:ss").timeIntervalSince(Date()) ?? 100.00 , since: Date())
            addTimerView()
        }
        buttonSearch.setTitle("", for: .normal)
        buttonNextSearch.setTitle("", for: .normal)
        buttonBack.setTitle("", for: .normal)
    }
    
    override func setupUI() {
        hideKeyboardWhenTappedAround()
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(cellType: Template1TBVCell.self)
        detailTableView.register(cellType: Template2TBVCell.self)
        detailTableView.register(cellType: Template3TBVCell.self)
        detailTableView.register(cellType: Template4TBVCell.self)
        detailTableView.register(cellType: ImagesGocTBVCell.self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panTapPro))
        linkWebImage.addGestureRecognizer(panGesture)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLinkWeb))
        linkWebImage.addGestureRecognizer(tap)
    }
    
    @objc func viewProfileUser(sender: UIPanGestureRecognizer){
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.userId = dataDetail[0].id_user ?? 0
//        vc.callAPIRecentComment()
//        vc.callApiProfile()
//        vc.callAPIUserEvent()
        self.navigationController?.pushViewController(vc, animated: true)
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

    
    @objc func tapLinkWeb(sender: UITapGestureRecognizer) {
        guard let url = URL(string: "https://futurelove.online/detail/" + String(idToanBoSuKien) + "/1") else { return }
        UIApplication.shared.open(url)
    }
    var fullscreenView: UIView?
    var initialImageScale: CGFloat = 1.0
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

//    @objc func downloadButtonTapped(_ sender: UITapGestureRecognizer) {
//        if let image = self.detailImage.image {
//            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
//        }
//    }
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
    @objc func tapAnhNu(sender: UITapGestureRecognizer) {
        fullscreenView = UIView(frame: view.bounds)
        fullscreenView?.backgroundColor = .black
        fullscreenView?.alpha = 0
        
        var zoomedImageView = UIImageView(frame: self.view.frame)
        zoomedImageView.contentMode = .scaleAspectFit
        
        fullscreenView?.addSubview(zoomedImageView)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler))
        fullscreenView?.addGestureRecognizer(pinchGesture)
        
        let url = URL(string: self.dataDetail[0].link_nu_goc ?? "" ?? "")
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
    @objc func tapAnhNam(sender: UITapGestureRecognizer) {
        fullscreenView = UIView(frame: view.bounds)
        fullscreenView?.backgroundColor = .black
        fullscreenView?.alpha = 0
        
        var zoomedImageView = UIImageView(frame: self.view.frame)
        zoomedImageView.contentMode = .scaleAspectFit
        
        fullscreenView?.addSubview(zoomedImageView)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler))
        fullscreenView?.addGestureRecognizer(pinchGesture)
        
        let url = URL(string: self.dataDetail[0].link_nam_goc ?? "" ?? "")
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
    @IBAction func btnSlideMenu(_ sender: Any) {
        let vc = SlideMenuViewController(data: dataDetail)
        vc.modalPresentationStyle = .overFullScreen
        vc.data = dataDetail
        vc.delegate = self
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        self.present(vc, animated: false)
    }
    // MARK: - Call Api

    func callApiDetailEvent() {
        APIService.shared.getDetailEvent(id: data){ result, error in
            if let result = result{
                self.dataDetail = result.sukien
                self.detailTableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Changekeyboard
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        keyboardScrollView.contentInset = contentInset
        keyboardScrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        keyboardScrollView.contentInset = contentInset
        keyboardScrollView.scrollIndicatorInsets = contentInset
    }
    
}

// MARK: - extension UITableView

extension EventViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if dataDetail.count  > 0{
                return 1
            }
            return 0
        }
        return dataDetail.count
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesGocTBVCell", for: indexPath) as! ImagesGocTBVCell
            cell.labelNameNam.text = "Male Name: " + (self.dataDetail[0].ten_nam ?? "")
            cell.labelNameNu.text =  "Female Name: " + (self.dataDetail[0].ten_nu ?? "")
            cell.labelUserNameCreator.text = self.userName
            let urlLinkProfile = URL(string: self.LinkProfile)
            let processorLinkProfile = DownsamplingImageProcessor(size: cell.imageUserName.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 50)
            cell.imageUserName.kf.indicatorType = .activity
            cell.imageUserName.kf.setImage(
                with: urlLinkProfile,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processorLinkProfile),
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
            let tapClickProfiles = UITapGestureRecognizer(target: self, action: #selector(viewProfileUser))
            let clickClickProfiles = UIPanGestureRecognizer(target: self, action: #selector(viewProfileUser))

            cell.labelNameNam.isUserInteractionEnabled = true
            cell.labelUserNameCreator.isUserInteractionEnabled = true
            cell.labelNameNu.isUserInteractionEnabled = true
            cell.imageUserName.isUserInteractionEnabled = true
            
            cell.labelUserNameCreator.addGestureRecognizer(tapClickProfiles)
            cell.imageUserName.addGestureRecognizer(tapClickProfiles)
            cell.labelNameNam.addGestureRecognizer(tapClickProfiles)
            cell.labelNameNu.addGestureRecognizer(tapClickProfiles)
            cell.buttonUserNameCreator.addGestureRecognizer(clickClickProfiles)
            
            let url = URL(string: self.dataDetail[0].link_nu_goc ?? "")
            let processor = DownsamplingImageProcessor(size: cell.image2Nu.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.image2Nu.kf.indicatorType = .activity
            cell.image2Nu.kf.setImage(
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
            let clickImageNu = UIPanGestureRecognizer(target: self, action: #selector(panTapPro))
            cell.buttonNu.addGestureRecognizer(clickImageNu)
            let tapNu = UITapGestureRecognizer(target: self, action: #selector(tapAnhNu))
            cell.buttonNu.addGestureRecognizer(tapNu)
            let clickImageNam = UIPanGestureRecognizer(target: self, action: #selector(panTapPro))
            cell.buttonNam.addGestureRecognizer(clickImageNam)
            let tapNam = UITapGestureRecognizer(target: self, action: #selector(tapAnhNam))
            cell.buttonNam.addGestureRecognizer(tapNam)
            //_____________________________________________________________________________
            let url_nam = URL(string: self.dataDetail[0].link_nam_goc ?? "")
            let processor_nam = DownsamplingImageProcessor(size: cell.image1Nam.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.image1Nam.kf.indicatorType = .activity
            cell.image1Nam.kf.setImage(
                with: url_nam,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor_nam),
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
            return cell
        }
        let item = dataDetail[indexPath.row]
        if item.id_template == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template4TBVCell", for: indexPath) as? Template4TBVCell else {
                return UITableViewCell()
            }
            cell.configCellDetail(model: dataDetail[indexPath.row])
            return cell
        } else if item.id_template == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template3TBVCell", for: indexPath) as? Template3TBVCell else {
                return UITableViewCell()
            }
            cell.configCellDetail(model: dataDetail[indexPath.row])
            return cell
        } else if item.id_template == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template2TBVCell", for: indexPath) as? Template2TBVCell else {
                return UITableViewCell()
            }
            cell.configCellDetail(model: dataDetail[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template1TBVCell", for: indexPath) as? Template1TBVCell else {
                return UITableViewCell()
            }
            cell.configCellDetail(model: dataDetail[indexPath.row])
            return cell
        }
        
        
        
    }
}

extension EventViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 400
        } else {
            let height = UIScreen.main.bounds.size.width * 200 / 420
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            vc.userId = dataDetail[0].id_user ?? 0
            vc.callAPIRecentComment()
            vc.callApiProfile()
            vc.callAPIUserEvent()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 1{
            let vc = DetailEventsViewController(data: data)
            vc.index = dataDetail[indexPath.row].so_thu_tu_su_kien ?? 1
            print( dataDetail[indexPath.row].so_thu_tu_su_kien ?? 1)
            vc.dataDetail = dataDetail[indexPath.row]
            vc.idToanBoSuKien = idToanBoSuKien
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EventViewController: SlideMenuprotocol {
    func navigeteHome() {
        self.dismiss(animated: false)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func navigateDetailComment(at index: Int, dataEvent: EventModel) {
        let vc = DetailEventsViewController(data: data)
        vc.index = index + 1
        vc.dataDetail = dataEvent
        vc.idToanBoSuKien = data
        self.dismiss(animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
extension String{
    func toDate(format : String) -> Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}
