//
//  mhchinhController.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 05/01/2024.
//

import UIKit
import Kingfisher

class mhchinhController: UIViewController {
    @IBOutlet weak var buttonnewproject:UIButton!
   
    @IBOutlet weak var theloaiclv:UICollectionView!
    @IBOutlet weak var cacluachon:UICollectionView!
    var listTD=["video","images","events","loves","baby"]
    var listCategories=["Dance video","Troll video","China","Euro","India","Gym","Latin","Northern Europe","Marvel","Japanese"]
    var listTemplateVideo : [Temple2VideoModel] = [Temple2VideoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonnewproject.setTitle("", for: .normal)
        theloaiclv.register(UINib(nibName: "tieudeclv", bundle: nil), forCellWithReuseIdentifier: "tieudeclv")
        cacluachon.register(UINib(nibName: "cacluachonclv", bundle: nil), forCellWithReuseIdentifier: "cacluachonclv")
       
       
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
extension mhchinhController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == theloaiclv{
            return listTD.count
        }
       
            return listCategories.count
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == theloaiclv{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tieudeclv", for: indexPath) as! tieudeclv
            cell.buttonTD.setTitle(listTD[indexPath.row], for: .normal)
            return cell
        }
      
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonclv", for: indexPath) as! cacluachonclv
            cell.labelNameCategori.text=listCategories[indexPath.row]
       
        APIService.shared.listAllTemplateVideoSwap(page:1,categories: indexPath.row + 1){response,error in
           
            cell.listTemplateVideo = response
            cell.thanhphanclvcell.reloadData()
        }
        cell.thanhphanclvcell.register(UINib(nibName: "thanhphanconclv", bundle: nil), forCellWithReuseIdentifier: "thanhphanconclv")
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension mhchinhController: UICollectionViewDelegateFlowLayout {
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
        if collectionView == theloaiclv{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 150)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/3-10, height: 30)
        }
     
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 200)
            }
            return CGSize(width: (UIScreen.main.bounds.width), height: 200)
       
    }
}



