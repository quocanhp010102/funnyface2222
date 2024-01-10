//
//  cacluachonclv.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 08/01/2024.
//

import UIKit
import Kingfisher

class cacluachonclv: UICollectionViewCell {
    @IBOutlet weak var viewchinh:UIView!
    @IBOutlet weak var thanhphanclvcell:UICollectionView!
    var parent: UIViewController?
    @IBOutlet weak var labelNameCategori:UILabel!
    var listTemplateVideo : [Temple2VideoModel] = [Temple2VideoModel]()
    var stt=0
    override func awakeFromNib() {
        super.awakeFromNib()
     
        //print(self.labelso.text)
        
    }
  
    
}
extension cacluachonclv: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listTemplateVideo.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("heloooo" + String(indexPath.row))
//        let storyBoard : UIStoryboard = UIStoryboard(name: "mhchinh", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SwapVideoDetailVC") as! SwapVideoDetailVC
//
//        self.present(nextViewController, animated:true, completion:nil)
        if let parentVC = findParentViewController(of: UIViewController.self) {
                let nextViewController = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
                nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
                
                parentVC.present(nextViewController, animated: true, completion: nil)
            }
//        let vc = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
//        vc.itemLink = self.listTemplateVideo[indexPath.row]
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
//        if let parentVC = parent as? mhchinhController {
//            let vc = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
//            vc.itemLink = self.listTemplateVideo[indexPath.row]
//            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//            parentVC.present(vc, animated: true, completion: nil)
//            // parentVC is someViewController
//        } else if let parentVC = parent as? mhchinhController {
//            print("hellll")
//            
//            // parentVC is anotherViewController
//        }
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thanhphanconclv", for: indexPath) as! thanhphanconclv
      //  cell.labelName.text = "asdfasdfasdfsdf"
        cell.imageVideo.layer.cornerRadius = 10
        cell.imageVideo.layer.masksToBounds = true
        cell.labelName.text = self.listTemplateVideo[indexPath.row].noi_dung ?? ""
        let url = URL(string: self.listTemplateVideo[indexPath.row].thumbnail ?? "")
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

extension cacluachonclv: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        }
        return CGSize(width: (UIScreen.main.bounds.width)/3-10, height: 150)
    }
}


extension UIResponder {
    func findParentViewController<T>(of type: T.Type) -> T? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let viewController = currentResponder as? T {
                return viewController
            }
            responder = currentResponder.next
        }
        return nil
    }
}
