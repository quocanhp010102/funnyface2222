//
//  ProfileViewController.swift
//  Future Love
//
//

import UIKit
import AlamofireImage
import Kingfisher

class ProfileViewController: UIViewController {
    var isVideoSeleced = false
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var buttonRemoveAccount: UIButton!
    @IBOutlet weak var buttonEvent: UIButton!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var buttonComment: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            isVideoSeleced = false
            self.recentCommentTableView.reloadData()
            //show popular view
        case 1:
            isVideoSeleced = true
            self.loadMoreDataVideoSwaped(page: 1)
            self.recentCommentTableView.reloadData()
        default:
            break;
        }
    }
    
    var userId: Int = 0
    var dataRecentCommemt: [CommentUser] = []
    var dataUserEvent: [Sukien] = []
    var listUserSearch:[UserSearchModel] = [UserSearchModel]()
    var isSearchUser = false
    var listVideoSwaped = [ResultVideoModel]()
    @IBOutlet weak var recentCommentTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var noCommentLabel: UILabel!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var countEventLabel: UILabel!
    @IBOutlet weak var countViewLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ipRegisterLabel: UILabel!
    @IBOutlet weak var deviceRegisterLabel: UILabel!

    @IBOutlet weak var countCommentLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var removeAccountButton: UIButton!
    @IBOutlet weak var ButtonAlert: UIButton!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundView.gradient()
        isSearchUser = false
        callApiProfile()
        callAPIUserEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        removeAccountButton.layer.cornerRadius = 10
        removeAccountButton.clipsToBounds = true
        
        buttonSearch.setTitle("", for: .normal)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonLogout.setTitle("Logout", for: .normal)
        buttonRemoveAccount.setTitle("Remove My Account?", for: .normal)
        buttonEvent.setTitle("", for: .normal)
        buttonView.setTitle("", for: .normal)
        buttonComment.setTitle("", for: .normal)
        ButtonAlert.setTitle("", for: .normal)
    }
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        recentCommentTableView.delegate = self
        recentCommentTableView.dataSource = self
        recentCommentTableView.register(cellType: DetailCommentTableViewCell.self)
        recentCommentTableView.register(cellType: UserSearchTBVCell.self)
        recentCommentTableView.register(cellType: RecentCommentTableViewCell.self)
    }
    
    func searchUserPro(textSearch:String){
        APIService.shared.APISearchUser(nameSearch: textSearch ) { result, error in
            self.listUserSearch = result
        }
    }
    
    @IBAction func removeAccountPro(){
        let vc = InputPasswordVC(nibName: "InputPasswordVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    func loadMoreDataVideoSwaped(page:Int){
        APIService.shared.getRecentVideoSwap(user: self.userId, page: page ) { result, error in
            if let result = result{
                self.listVideoSwaped = result
                self.recentCommentTableView.reloadData()
            }
        }
    }
    func callApiProfile() {
        APIService.shared.getProfile(user: self.userId ) { result, error in
            if let success = result {
                if let idUser = success.id_user{
                    self.userNameLabel.text = success.user_name
                    self.countEventLabel.text = success.count_sukien?.toString()
                    self.countCommentLabel.text = success.count_comment?.toString()
                    self.countViewLabel.text = (success.count_view ?? 0).toString()
                    self.ipRegisterLabel.text = "Ip Register: " + (success.ip_register ?? "")
                    self.deviceRegisterLabel.text = "Device Register: " + (success.device_register ?? "")
                    self.emailLabel.text = success.email ?? ""
                    let escapedString = success.link_avatar?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                    if let url = URL(string: escapedString ?? "") {
                        let processor = DownsamplingImageProcessor(size: self.avatarImage.bounds.size)
                                     |> RoundCornerImageProcessor(cornerRadius: 20)
                        self.avatarImage.kf.indicatorType = .activity
                        self.avatarImage.kf.setImage(
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
                }else{
                    if let message = success.ketqua{
                        let alert = UIAlertController(title: "Error Get Data", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                                case .default:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                                case .cancel:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                                case .destructive:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func callAPIRecentComment() {
        APIService.shared.getRecentComment(user: self.userId) { result, error in
            if let success = result {
                self.dataRecentCommemt = success.comment_user.reversed()
                self.recentCommentTableView.reloadData()
                if self.dataRecentCommemt.count == 0 {
                    self.noCommentLabel.isHidden = false
                } else {
                    self.noCommentLabel.isHidden = true
                }
                self.recentCommentTableView.reloadData()
            }
        }
    }
    func callAPIUserEvent() {
        APIService.shared.getUserEvent(user:  self.userId) { result, error in
            if let success = result {
                let data = success.list_sukien.compactMap {$0.sukien.first }
                self.dataUserEvent = data
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true)
    }
    
    @IBAction func userEventBtn(_ sender: Any) {
        let vc = UserEventViewController(nibName: "UserEventViewController", bundle: nil)
        vc.data = self.dataUserEvent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickSearch(_ sender: Any) {
        APIService.shared.APISearchUser(nameSearch: userNameTextField.text ?? "" ) { result, error in
            self.isSearchUser = true
            self.listUserSearch = result
            self.recentCommentTableView.reloadData()
        }
    }
    
    @IBAction func LogOutBtn(_ sender: Any) {
        AppConstant.logout()
        self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isVideoSeleced == true{
            return listVideoSwaped.count
        }
        if isSearchUser == false{
            return dataRecentCommemt.count
        }
        return listUserSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isVideoSeleced == true{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCommentTableViewCell", for: indexPath) as? RecentCommentTableViewCell else {
                return UITableViewCell()
            }
            let url = URL(string: listVideoSwaped[indexPath.row].link_image ?? "")
            let processor = DownsamplingImageProcessor(size: cell.avatarImage.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.avatarImage.kf.indicatorType = .activity
            cell.avatarImage.kf.setImage(
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
            cell.dateLabel.text = listVideoSwaped[indexPath.row].thoigian_taovid ?? ""
            cell.descriptionLabel.text = listVideoSwaped[indexPath.row].thoigian_swap ?? ""
            return cell
        }
        if isSearchUser == false{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {
                return UITableViewCell()
            }
            cell.id_comment = "\(dataRecentCommemt[indexPath.row].id_comment)"
            cell.id_user_comment = "\(dataRecentCommemt[indexPath.row].id_user)"
            cell.linkAvatar = dataRecentCommemt[indexPath.row].avatar_user ?? ""
            cell.descriptionMain = dataRecentCommemt[indexPath.row].noi_dung_cmt ?? ""
            cell.thoi_gian_release = dataRecentCommemt[indexPath.row].thoi_gian_release ?? ""
            cell.noi_dung_cmt = dataRecentCommemt[indexPath.row].noi_dung_cmt ?? ""
            cell.configCellReComment(model: dataRecentCommemt[indexPath.row])
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserSearchTBVCell", for: indexPath) as? UserSearchTBVCell else {
            return UITableViewCell()
        }
        let url = URL(string: listUserSearch[indexPath.row].link_avatar ?? "")
        let processor = DownsamplingImageProcessor(size: cell.imageAvatar.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.imageAvatar.kf.indicatorType = .activity
        cell.imageAvatar.kf.setImage(
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
        cell.labelName.text = listUserSearch[indexPath.row].user_name
        cell.labelEmail.text  = listUserSearch[indexPath.row].email
        cell.labelIpRegister.text  =  (listUserSearch[indexPath.row].ip_register ?? "No Record Ip")
        cell.labelDevice_register.text  = (listUserSearch[indexPath.row].device_register ?? "No Record Device")
        cell.labelCount_sukien.text  = String(listUserSearch[indexPath.row].count_sukien ?? 0) + " event"
        cell.labelCount_comment.text  = String(listUserSearch[indexPath.row].count_comment ?? 0) + " Comment"
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isVideoSeleced == true{
            return UITableView.automaticDimension
        }
        if isSearchUser == false{
            return UITableView.automaticDimension
        }
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isVideoSeleced == true{
            let vc = DetailSwapVideoVC(nibName: "DetailSwapVideoVC", bundle: nil)
            var itemDataSend:DetailVideoModel = DetailVideoModel()
            itemDataSend.idUser = self.listVideoSwaped[indexPath.row].id_user
            itemDataSend.id_video_swap = self.listVideoSwaped[indexPath.row].id_video
            itemDataSend.linkimg = self.listVideoSwaped[indexPath.row].link_image
            itemDataSend.link_vid_swap = self.listVideoSwaped[indexPath.row].link_vid_swap
            itemDataSend.ten_video = self.listVideoSwaped[indexPath.row].ten_su_kien
            itemDataSend.noidung = self.listVideoSwaped[indexPath.row].noidung_sukien
            itemDataSend.thoigian_sukien = self.listVideoSwaped[indexPath.row].thoigian_swap
            vc.itemDataSend = itemDataSend
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        
        }else{
            if isSearchUser == false{
                let vc = DetailEventsViewController(data: dataRecentCommemt[indexPath.row].id_toan_bo_su_kien ?? 0 )
                vc.index = dataRecentCommemt[indexPath.row].so_thu_tu_su_kien ?? 0
                vc.idToanBoSuKien = dataRecentCommemt[indexPath.row].id_toan_bo_su_kien ?? 0
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                self.userId = listUserSearch[indexPath.row].id_user ?? 0
                self.callAPIRecentComment()
                self.callApiProfile()
                self.callAPIUserEvent()
                isSearchUser = false
                self.recentCommentTableView.reloadData()
            }
        }
    }
    
}

extension ProfileViewController : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        APIService.shared.APISearchUser(nameSearch: textField.text ?? "" ) { result, error in
            self.isSearchUser = true
            self.listUserSearch = result
            self.dismiss(animated: true)
            textField.resignFirstResponder()
            self.recentCommentTableView.reloadData()
        }
        return true
    }
}
