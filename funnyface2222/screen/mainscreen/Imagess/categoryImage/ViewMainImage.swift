//
//  ViewMainImage.swift
//  funnyface2222
//
//  Created by quocanhppp on 16/01/2024.
//

//
//  ViewMainImage.swift
//  funnyface2222
//
//  Created by quocanhppp on 16/01/2024.
//

import UIKit
import Kingfisher

class ViewMainImage: UIViewController {

    @IBOutlet weak var cacluachonimageclv22:UICollectionView!
    @IBOutlet weak var backbtn:UIButton!
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    @IBOutlet weak var listCategory:UIButton!
    @IBAction func swapnext(){
        if let parentVC = findParentViewController(of: UIViewController.self) {
                let nextViewController = SwapImageAlbum(nibName: "SwapImageAlbum", bundle: nil)
               // nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
            nextViewController.idAlbum = self.listData[0].IDCategories
                parentVC.present(nextViewController, animated: true, completion: nil)
            }
    }
    var listData:[ListVideoModal] = [ListVideoModal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtn.setTitle("", for: .normal)
        listCategory.setTitle("", for: .normal)
        print("lít dataa ")
        print(self.listData)
        cacluachonimageclv22.register(UINib(nibName: "thanhviencell2", bundle: nil), forCellWithReuseIdentifier: "thanhviencell2")
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
extension ViewMainImage: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
        return listData.count
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonimageclv", for: indexPath) as! cacluachonimageclv
//           // cell.labelNameCategori.text=listCategories[indexPath.row]
//
//
//        cell.thanhvienimagecon.register(UINib(nibName: "thanhvienimagecon", bundle: nil), forCellWithReuseIdentifier: "thanhvienimagecon")
//            return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thanhviencell2", for: indexPath) as! thanhviencell2
        cell.imageVideo.layer.cornerRadius = 10
        cell.imageVideo.layer.masksToBounds = true
        cell.labelTuoi.text = self.listData[indexPath.row].dotuoi.toString()
        cell.labelName.text = self.listData[indexPath.row].thongtin
        //self.listData[indexPath.row].description ?? ""
        cell.labelTimeRun.text=self.listData[indexPath.row].mask
        print(self.listData[indexPath.row].image ?? "")
        let url = URL(string: self.listData[indexPath.row].image ?? "")
        let processor = DownsamplingImageProcessor(size: cell.imageVideo.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageVideo.kf.indicatorType = .activity
        cell.imageVideo.kf.setImage(
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
        return cell
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension ViewMainImage: UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: (UIScreen.main.bounds.width)/2.2-10, height: 200)
       
    }
}



