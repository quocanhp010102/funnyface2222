//
//  UserEventViewController.swift
//  FutureLove
//
//  Created by TTH on 08/08/2023.
//

import UIKit

class UserEventViewController: UIViewController {
    @IBOutlet weak var userEventTableView: UITableView!
    @IBOutlet weak var backGroundView: UIView!
    
    var data : [Sukien] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backGroundView.gradient()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userEventTableView.delegate = self
        userEventTableView.dataSource = self
        userEventTableView.register(cellType: Template1TBVCell.self)
        userEventTableView.register(cellType: Template2TBVCell.self)
        userEventTableView.register(cellType: Template3TBVCell.self)
        userEventTableView.register(cellType: Template4TBVCell.self)
        userEventTableView.separatorStyle = .none
    }


    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

// MARK: - extension UITableView

extension UserEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        if item.id_template == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template4TBVCell", for: indexPath) as? Template4TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: data[indexPath.row])
            return cell
        } else if item.id_template == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template3TBVCell", for: indexPath) as? Template3TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: data[indexPath.row])
            return cell
        } else if item.id_template == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template2TBVCell", for: indexPath) as? Template2TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: data[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Template1TBVCell", for: indexPath) as? Template1TBVCell else {
                return UITableViewCell()
            }
            cell.configCell(model: data[indexPath.row])
            return cell
        }
        
    }
    
}

extension UserEventViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.size.width * 200 / 390
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventViewController(data: data[indexPath.row].id_toan_bo_su_kien ?? 0)
        vc.idToanBoSuKien = data[indexPath.row].id_toan_bo_su_kien ?? 0
        var dataDetail: [EventModel] = [EventModel]()
        var sothutu_sukien = 1
        for indexList in data{
            var itemAdd:EventModel = EventModel()
            itemAdd.link_da_swap = indexList.link_da_swap
            itemAdd.count_comment = 0
            itemAdd.count_view = 0
            itemAdd.id = indexList.id
            itemAdd.id_user = indexList.id_user
            let dateNow = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
            let dateString = dateFormatter.string(from:dateNow)
            itemAdd.real_time = dateString
            //                            itemAdd.id_template = indexList.id_template
            itemAdd.link_nam_chua_swap = indexList.link_nam_chua_swap
            itemAdd.link_nu_chua_swap = indexList.link_nu_chua_swap
            itemAdd.link_nu_goc = indexList.link_nu_goc
            itemAdd.link_nam_goc = indexList.link_nam_goc
            itemAdd.noi_dung_su_kien = indexList.noi_dung_su_kien
            itemAdd.so_thu_tu_su_kien = sothutu_sukien
            sothutu_sukien = sothutu_sukien + 1
            itemAdd.ten_su_kien = indexList.ten_su_kien
            dataDetail.append(itemAdd)
        }
        vc.dataDetail = dataDetail
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
