//
//  EventView.swift
//  funnyface2222
//
//  Created by quocanhppp on 29/01/2024.
//

//
//  HomeViewController.swift
//  FutureLove
//
//  Created by TTH on 24/07/2023.
//

import UIKit
import SETabView
import AlamofireImage
import DeviceKit

class EventView: UIViewController, SETabItemProvider,UITextFieldDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonNextSearch: UIButton!

    var indexSelectPage = 0
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(named: "tab_home"), tag: 0)
    }
    var dataList_All: [Sukien] = []
    var listSukien : [List_sukien] = [List_sukien]()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var homeTableView: UITableView!

    @IBOutlet weak var profileBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // viewBackground.gradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSearch.setTitle("", for: .normal)
        buttonNextSearch.setTitle("", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        collectionView.register(UINib(nibName: PageHomeCLVCell.className, bundle: nil), forCellWithReuseIdentifier: PageHomeCLVCell.className)
        setupUI()
        callApiHome()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.homeTableView.reloadData()
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.homeTableView.reloadData()
            }
        }
       return true
    }
    func setupUI() {
        hideKeyboardWhenTappedAround()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(cellType: Template1TBVCell.self)
        homeTableView.register(cellType: Template2TBVCell.self)
        homeTableView.register(cellType: Template3TBVCell.self)
        homeTableView.register(cellType: Template4TBVCell.self)
        homeTableView.separatorStyle = .none
        
        if let url = URL(string: AppConstant.linkAvatar.asStringOrEmpty()){
            avatarImage.af.setImage(withURL: url)
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull For Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        homeTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        callApiHome()
        self.homeTableView.reloadData()
        refreshControl.endRefreshing()
    }
    @IBAction func searchBtn(_ sender: Any) {
        APIService.shared.searchComment(searchText:textFieldSearch.text ?? "" ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.homeTableView.reloadData()
            }
        }
    }
    func callApiHome() {
        APIService.shared.getLoveHistory(pageLoad: 1, idUser: String(AppConstant.userId ?? 0 ) ){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.listSukien = result.list_sukien
                self.homeTableView.reloadData()
            }
        }
    }
    @IBAction func actionNextProfile(_ sender: Any) {
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.userId = AppConstant.userId ?? 0
        vc.callAPIRecentComment()
        vc.callApiProfile()
        vc.callAPIUserEvent()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - extension UITableView

extension EventView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList_All.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataList_All[indexPath.row]
        if item.id_template == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template4TBVCell", for: indexPath) as? Template4TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: dataList_All[indexPath.row])
            return cell
        } else if item.id_template == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template3TBVCell", for: indexPath) as? Template3TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: dataList_All[indexPath.row])
            return cell
        } else if item.id_template == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template2TBVCell", for: indexPath) as? Template2TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: dataList_All[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template1TBVCell", for: indexPath) as? Template1TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: dataList_All[indexPath.row])
            return cell
        }
        
    }
    
}

extension EventView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return 400
        }
        let height = UIScreen.main.bounds.size.width * 200 / 390
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventViewController(data: dataList_All[indexPath.row].id_toan_bo_su_kien ?? 0)
        var dataDetail: [EventModel] = [EventModel]()
        if listSukien.count > indexPath.row{
            for indexList in listSukien[indexPath.row].sukien{
                var itemAdd:EventModel = EventModel()
                itemAdd.link_da_swap = indexList.link_da_swap
                itemAdd.count_comment = indexList.count_comment
                itemAdd.count_view = indexList.count_view
                itemAdd.id = indexList.id
                itemAdd.id_user = indexList.id_user
                itemAdd.id_template = indexList.id_template
                itemAdd.link_nam_chua_swap = indexList.link_nam_chua_swap
                itemAdd.link_nu_chua_swap = indexList.link_nu_chua_swap
                itemAdd.link_nu_goc = indexList.link_nu_goc
                itemAdd.link_nam_goc = indexList.link_nam_goc
                itemAdd.noi_dung_su_kien = indexList.noi_dung_su_kien
                itemAdd.phantram_loading = indexList.phantram_loading
                itemAdd.real_time = indexList.real_time
                itemAdd.so_thu_tu_su_kien = indexList.so_thu_tu_su_kien
                itemAdd.ten_nam = indexList.ten_nam
                itemAdd.ten_nu = indexList.ten_nu
                itemAdd.ten_su_kien = indexList.ten_su_kien
                dataDetail.append(itemAdd)
            }
            if listSukien[indexPath.row].sukien.count > 0{
                vc.idToanBoSuKien = listSukien[indexPath.row].sukien[0].id ?? 0
            }
            vc.dataDetail = dataDetail
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}
extension EventView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexSelectPage = indexPath.row
        APIService.shared.getLoveHistory(pageLoad: indexPath.row + 1, idUser: String(AppConstant.userId ?? 0 )){result, error in
            if let result = result{
                self.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                self.homeTableView.reloadData()
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

extension EventView: UICollectionViewDelegateFlowLayout {
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

