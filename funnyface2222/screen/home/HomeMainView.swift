//
//  HomeMainView.swift
//  funnyface2222
//
//  Created by quocanhppp on 22/01/2024.
//

import UIKit
import Kingfisher

class HomeMainView: UIViewController {
    var listTemplateVideo : [ResultVideoModel] = [ResultVideoModel]()
    @IBOutlet weak var cacluachon:UICollectionView!
    @IBOutlet weak var btntim:UIButton!
    @IBOutlet weak var btnthem:UIButton!
  //  @IBOutlet weak var showmore:UIButton!
    @IBAction func nextdd(){
        let storyboard = UIStoryboard(name: "HomeStaboad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "albumswaped") as! albumswaped
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        print("lisssss dataa")
        //print(self)
       
        APIService.shared.listAllVideoSwaped(page:1){response,error in
            vc.listTemplateVideo = response
            self.present(vc, animated: true, completion: nil)
            //self.cacluachon.reloadData()
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        showmore.layer.borderWidth = 0
        btntim.setTitle("", for: .normal)
        btnthem.setTitle("", for: .normal)
        
        cacluachon.register(UINib(nibName: "phantrencell", bundle: nil), forCellWithReuseIdentifier: "phantrencell")
        cacluachon.register(UINib(nibName: "phanduoicell", bundle: nil), forCellWithReuseIdentifier: "phanduoicell")
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
extension HomeMainView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
            return 2
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailSwapVideoVC(nibName: "DetailSwapVideoVC", bundle: nil)
//        var itemLink:DetailVideoModel = DetailVideoModel()
//        itemLink.linkimg = self.listTemplateVideo[indexPath.row].link_image
//        itemLink.link_vid_swap = self.listTemplateVideo[indexPath.row].link_vid_swap
//        itemLink.noidung = self.listTemplateVideo[indexPath.row].noidung_sukien
//        itemLink.id_sukien_video = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.id_video_swap = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.ten_video = self.listTemplateVideo[indexPath.row].ten_su_kien
//        itemLink.idUser = self.listTemplateVideo[indexPath.row].id_user
////            itemLink.thoigian_swap = Floatself.listTemplateVideo[indexPath.row].thoigian_taovid
////\            itemLink.device_tao_vid = self.listTemplateVideo[indexPath.row].thoigian_taovid
//        itemLink.thoigian_sukien = self.listTemplateVideo[indexPath.row].thoigian_taosk
//        itemLink.link_video_goc = self.listTemplateVideo[indexPath.row].link_vid_swap
//        itemLink.ip_tao_vid = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.link_vid_swap = self.listTemplateVideo[indexPath.row].link_vid_swap
//        vc.itemDataSend = itemLink
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phantrencell", for: indexPath) as! phantrencell
        
            APIService.shared.listAllVideoSwaped(page:1){response,error in
                cell.listTemplateVideo = response
                cell.cacluachon2.reloadData()
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phanduoicell", for: indexPath) as! phanduoicell
        APIService.shared.getLoveHistory(pageLoad: 1, idUser: String(AppConstant.userId ?? 0 ) ){result, error in
            if let result = result{
                cell.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                print("lít dataa")
                print(cell.dataList_All)
                cell.listSukien = result.list_sukien
                cell.cacluachon2.reloadData()
            }
        }
        
    //    print(cell.dataList_All[indexPath.row].id_user)
       
        return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension HomeMainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: 800)
        }
        if indexPath.row == 0 {
            return CGSize(width: (UIScreen.main.bounds.width), height: 500)
        }
        return CGSize(width: (UIScreen.main.bounds.width), height: 800)
        
    }
}
