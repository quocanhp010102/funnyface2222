//
//  listSwaped.swift
//  funnyface2222
//
//  Created by quocanhppp on 18/01/2024.
//

import UIKit
import Kingfisher

class listSwaped: UIViewController {
    @IBOutlet weak var listdaSwap:UICollectionView!
    @IBOutlet weak var buttonBack:UIButton!
    @IBOutlet weak var buttonShare:UIButton!
    var listImaged:[String]=[String]()
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
        buttonBack.setTitle("", for: .normal)
        buttonShare.setTitle("", for: .normal)
        listdaSwap.register(UINib(nibName: "listImageSwapedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listImageSwapedCollectionViewCell")
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
extension listSwaped: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
        return listImaged.count
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonimageclv", for: indexPath) as! cacluachonimageclv
//           // cell.labelNameCategori.text=listCategories[indexPath.row]
//
//
//        cell.thanhvienimagecon.register(UINib(nibName: "thanhvienimagecon", bundle: nil), forCellWithReuseIdentifier: "thanhvienimagecon")
//            return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listImageSwapedCollectionViewCell", for: indexPath) as! listImageSwapedCollectionViewCell
        cell.images.layer.cornerRadius = 10
        cell.images.layer.masksToBounds = true
       
        //self.listData[indexPath.row].description ?? ""
      
       
        let url = URL(string: self.listImaged[indexPath.row] ?? "")
        let processor = DownsamplingImageProcessor(size: cell.images.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.images.kf.indicatorType = .activity
        cell.images.kf.setImage(
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

extension listSwaped: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: (UIScreen.main.bounds.width)/3.2 - 20, height: 400)
            }
        return CGSize(width: (UIScreen.main.bounds.width)/4-10, height: 200)
       
    }
}



