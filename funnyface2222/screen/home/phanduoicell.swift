//
//  phanduoicell.swift
//  funnyface2222
//
//  Created by quocanhppp on 23/01/2024.
//

import UIKit
import Kingfisher

class phanduoicell: UICollectionViewCell {
    @IBOutlet weak var cacluachon2:UICollectionView!
    
    var dataList_All: [Sukien] = []
    var listSukien : [List_sukien] = [List_sukien]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.cacluachon2.reloadData()
   // https://metatechvn.store/lovehistory/page/&trang
        cacluachon2.register(UINib(nibName: "celleventduoi", bundle: nil), forCellWithReuseIdentifier: "celleventduoi")
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension phanduoicell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count::::::")
        print(self.dataList_All.count)
        if self.dataList_All.count <= 3{
            return self.dataList_All.count
        }
            
        return 3
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celleventduoi", for: indexPath) as! celleventduoi
        var profiles:ProfileModel = ProfileModel()
        APIService.shared.getProfile(user: self.dataList_All[indexPath.row].id_user ?? 1 ) { result, error in
            if let success = result {
                cell.profile = success
                
                cell.labelUserName.text = success.user_name
                let escapedString = success.link_avatar?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                let linkImagePro = escapedString?.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online", options: .literal, range: nil)
               
                if let url = URL(string: linkImagePro ?? "") {
                    let processor = DownsamplingImageProcessor(size: cell.imageUserAvatar.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 5)
                    cell.imageUserAvatar.kf.indicatorType = .activity
                    cell.imageUserAvatar.kf.setImage(
                        with: url,
                        placeholder: UIImage(named: "hoapro"),
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
            }}
       
       
//        let removeSuot = self.linkImageVideoSwap.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
        
        
       
        //cell.labelUserName.text = cell.profile.user_name
        cell.lablenamesk.text = self.dataList_All[indexPath.row].ten_su_kien
        cell.lablenamesk2.text = self.dataList_All[indexPath.row].noi_dung_su_kien
        cell.lablenamesk3.text = self.dataList_All[indexPath.row].count_comment?.toString()
        cell.lablenamesk4.text = self.dataList_All[indexPath.row].count_view?.toString()
        cell.lablenamesk5.text = self.dataList_All[indexPath.row].real_time
       
        
        
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension phanduoicell: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: UIScreen.main.bounds.width, height: 200)
            }
        return CGSize(width: (UIScreen.main.bounds.width), height: 200)
       
    }
}
