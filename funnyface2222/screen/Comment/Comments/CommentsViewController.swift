//
//  CommentsViewController.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit
import SETabView
import SwiftKeychainWrapper

class CommentsViewController: UIViewController , SETabItemProvider,UITextFieldDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var indexSelectPage = 0
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!

    var dataList_All: [Sukien] = []
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_comments(), tag: 0)
    }
    var ListIDUser_Block:[Int] = [Int]()

    var dataDetail: [EventModel] = []
    var dataComment : [DataComment] = []
    var isLoadingData = false
    var maxPage: Int = 0
    var currentPage: Int = 1
    var refreshControl: UIRefreshControl!
    var listSukien : [List_sukien] = [List_sukien]()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewBackGround.gradient()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.dataComment.removeAll()
                for item in self.dataList_All{
                    var itemAdd : DataComment = DataComment()
                    itemAdd.noi_dung_cmt = item.ten_su_kien
                    itemAdd.dia_chi_ip = item.noi_dung_su_kien
                    itemAdd.thoi_gian_release = item.real_time
                    itemAdd.id_toan_bo_su_kien = item.id_toan_bo_su_kien
                    itemAdd.so_thu_tu_su_kien = item.so_thu_tu_su_kien
                    self.dataComment.append(itemAdd)
                }
                self.commentTableView.reloadData()
            }
        }
    }
    
    func reloadBlockAccount(DataXoa:String){
        ListIDUser_Block.removeAll()
        var dataNewComment : [DataComment] = dataComment
        if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
            for item in 0..<number_user{
                let idUserNumber = "id_user_" + String(item)
                if let idUser: String = KeychainWrapper.standard.string(forKey: idUserNumber){
                    var kiemtra = 0
                    for itemDataComment in dataNewComment{
                        if (itemDataComment.noi_dung_cmt)?.urlEncoded == idUser{
                            if kiemtra >= 0{
                                dataNewComment.remove(at: kiemtra)
                                kiemtra = kiemtra - 1
                            }
                        }else if itemDataComment.noi_dung_cmt == DataXoa{
                            if kiemtra >= 0{
                                dataNewComment.remove(at: kiemtra)
                                kiemtra = kiemtra - 1
                            }
                        }else{
                            kiemtra = kiemtra + 1
                        }
                    }
                }
            }
            dataComment = dataNewComment
            commentTableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.dataComment.removeAll()
                for item in self.dataList_All{
                    var itemAdd : DataComment = DataComment()
                    itemAdd.noi_dung_cmt = item.ten_su_kien
                    itemAdd.dia_chi_ip = item.noi_dung_su_kien
                    itemAdd.thoi_gian_release = item.real_time
                    itemAdd.id_toan_bo_su_kien = item.id_toan_bo_su_kien
                    itemAdd.so_thu_tu_su_kien = item.so_thu_tu_su_kien
                    self.dataComment.append(itemAdd)
                }
                self.commentTableView.reloadData()
            }
        }
        return true
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.dataComment.removeAll()
                for item in self.dataList_All{
                    var itemAdd : DataComment = DataComment()
                    itemAdd.noi_dung_cmt = item.ten_su_kien
                    itemAdd.dia_chi_ip = item.noi_dung_su_kien
                    itemAdd.thoi_gian_release = item.real_time
                    itemAdd.id_toan_bo_su_kien = item.id_toan_bo_su_kien
                    itemAdd.so_thu_tu_su_kien = item.so_thu_tu_su_kien
                    self.dataComment.append(itemAdd)
                }
                self.commentTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        getComment(page: currentPage)
        callAPIgetdataComment()
        textFieldSearch.delegate = self
        collectionView.register(UINib(nibName: PageHomeCLVCell.className, bundle: nil), forCellWithReuseIdentifier: PageHomeCLVCell.className)
        buttonBack.setTitle("", for: .normal)
        buttonSearch.setTitle("", for: .normal)
    }
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.register(cellType: DetailCommentTableViewCell.self)
        commentTableView.separatorStyle = .none
        if let url = URL(string: AppConstant.linkAvatar.asStringOrEmpty()) {
            profileImage.af.setImage(withURL: url)
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        commentTableView.refreshControl = refreshControl
    }
    @objc func refreshData() {
        callAPIgetdataComment()
        self.commentTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.userId = AppConstant.userId ?? 0
        vc.callAPIRecentComment()
        vc.callApiProfile()
        vc.callAPIUserEvent()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callAPIgetdataComment() {
        APIService.shared.getPageComment(page: 1, idUser: String(AppConstant.userId ?? 0)) { result, error in
            if let success = result{
                self.dataComment = success.comment
                self.maxPage = 1
                var dataNewComment : [DataComment] = self.dataComment
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
                    for item in 0..<number_user{
                        let idUserNumber = "id_user_" + String(item)
                        if let idUser: String = KeychainWrapper.standard.string(forKey: idUserNumber){
                            var kiemtra = 0
                            for itemDataComment in dataNewComment{
                                if (itemDataComment.noi_dung_cmt)?.urlEncoded == idUser{
                                    dataNewComment.remove(at: kiemtra)
                                    kiemtra = kiemtra - 1
                                }else{
                                    kiemtra = kiemtra + 1
                                }
                            }
                        }
                    }
                    self.dataComment = dataNewComment
                }
                self.commentTableView.reloadData()
                
            }
        }
    }
    
    
    func getComment(page: Int) {
        APIService.shared.getPageComment(page: page, idUser: String(AppConstant.userId ?? 0) ) { result, error in
            if let success = result{
                self.dataComment = success.comment
                self.maxPage = 1
                var dataNewComment : [DataComment] = self.dataComment
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
                    for item in 0..<number_user{
                        let idUserNumber = "id_user_" + String(item)
                        if let idUser: String = KeychainWrapper.standard.string(forKey: idUserNumber){
                            var kiemtra = 0
                            for itemDataComment in dataNewComment{
                                if (itemDataComment.noi_dung_cmt)?.urlEncoded == idUser{
                                    dataNewComment.remove(at: kiemtra)
                                    kiemtra = kiemtra - 1
                                }else{
                                    kiemtra = kiemtra + 1
                                }
                            }
                        }
                    }
                    self.dataComment = dataNewComment
                }
                self.commentTableView.reloadData()
            }
        }
        
    }
}
// MARK: - Extension UITableView
extension CommentsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommentTableViewCell", for: indexPath) as? DetailCommentTableViewCell else {
            return UITableViewCell()
        }
        cell.id_comment = "\(dataComment[indexPath.row].id_comment)"
        cell.id_user_comment = "\(dataComment[indexPath.row].id_user)"
        cell.linkAvatar = dataComment[indexPath.row].avatar_user ?? ""
        cell.descriptionMain = dataComment[indexPath.row].noi_dung_cmt ?? ""
        cell.thoi_gian_release = dataComment[indexPath.row].thoi_gian_release ?? ""
        cell.noi_dung_cmt = dataComment[indexPath.row].noi_dung_cmt ?? ""
        cell.configCellComment(model: dataComment[indexPath.row])
        return cell
    }
}

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailEventsViewController(data: dataComment[indexPath.row].id_toan_bo_su_kien ?? 0 )
        vc.idToanBoSuKien = dataComment[indexPath.row].id_toan_bo_su_kien ?? 0
        vc.index = dataComment[indexPath.row].so_thu_tu_su_kien ?? 0
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if !isLoadingData && offsetY > contentHeight - screenHeight {
            isLoadingData = true
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        currentPage += 1
        guard currentPage <= maxPage else { return }
        getComment(page: currentPage)
    }
}


extension CommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexSelectPage = indexPath.row
        APIService.shared.getPageComment(page: self.indexSelectPage, idUser: String(AppConstant.userId ?? 0)) { result, error in
            if let success = result{
                self.dataComment = success.comment
                self.maxPage = 1
                var dataNewComment : [DataComment] = self.dataComment
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
                    for item in 0..<number_user{
                        let idUserNumber = "id_user_" + String(item)
                        if let idUser: String = KeychainWrapper.standard.string(forKey: idUserNumber){
                            var kiemtra = 0
                            for itemDataComment in dataNewComment{
                                if (itemDataComment.noi_dung_cmt)?.urlEncoded == idUser{
                                    dataNewComment.remove(at: kiemtra)
                                    kiemtra = kiemtra - 1
                                }else{
                                    kiemtra = kiemtra + 1
                                }
                            }
                        }
                    }
                    self.dataComment = dataNewComment
                }
                self.commentTableView.reloadData()
                self.collectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageHomeCLVCell.className, for: indexPath) as! PageHomeCLVCell
        cell.pageLabel.text = String(indexPath.row + 1)
        if indexPath.row == indexSelectPage{
            cell.backgroundColor = UIColor.green
        }else{
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension CommentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width/24 - 5, height: 50)
        }
        return CGSize(width: UIScreen.main.bounds.width/12 - 5, height: 50)
    }
}

