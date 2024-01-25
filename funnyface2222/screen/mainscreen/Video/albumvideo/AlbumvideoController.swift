//
//  AlbumvideoController.swift
//  funnyface2222
//
//  Created by quocanhppp on 19/01/2024.
//

//
//  ViewMainImage.swift
//  funnyface2222
//
//  Created by quocanhppp on 16/01/2024.
//



import UIKit
import Kingfisher

class AlbumvideoController: UIViewController {

    @IBOutlet weak var cacluachonimageclv22:UICollectionView!
    @IBOutlet weak var backbtn:UIButton!
    @IBAction func BackApp(){
        self.dismiss(animated: true)
    }
    @IBAction func listCate(){
        let refreshAlert = UIAlertController(title: "Chọn list video", message: "", preferredStyle: .alert)

        // Tùy chỉnh nền và màu sắc chữ
        if let alertView = refreshAlert.view.subviews.first?.subviews.first {
            alertView.backgroundColor = UIColor.black

            // Tìm các label trong alertView và đặt màu chữ là trắng
            for subview in alertView.subviews {
                if let label = subview as? UILabel {
                    label.textColor = UIColor.white
                }
            }
        }
        for index in 1...10 {
            refreshAlert.addAction(UIAlertAction(title: "album \(index)", style: .default, handler: { (action: UIAlertAction!) in
                
                APIService.shared.listAllTemplateVideoSwap(page:1,categories: index){response,error in
                   
                    self.listTemplateVideo = response
                   self.cacluachonimageclv22.reloadData()
                }
            }))
        }
       

        present(refreshAlert, animated: true, completion: nil)

    }
    @IBOutlet weak var listCategory:UIButton!
    @IBAction func swapnext(){
//        if let parentVC = findParentViewController(of: UIViewController.self) {
//                let nextViewController = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
//                nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
//                
//                parentVC.present(nextViewController, animated: true, completion: nil)
//            }
    }
    var listTemplateVideo : [Temple2VideoModel] = [Temple2VideoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtn.setTitle("", for: .normal)
        listCategory.setTitle("", for: .normal)
        print("lít dataa ")
        //print(self.listData)
        cacluachonimageclv22.register(UINib(nibName: "VideoCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCellCollectionViewCell")
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
extension AlbumvideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
        return listTemplateVideo.count
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parentVC = findParentViewController(of: UIViewController.self) {
                let nextViewController = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
                nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
                
                parentVC.present(nextViewController, animated: true, completion: nil)
            }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonimageclv", for: indexPath) as! cacluachonimageclv
//           // cell.labelNameCategori.text=listCategories[indexPath.row]
//
//
//        cell.thanhvienimagecon.register(UINib(nibName: "thanhvienimagecon", bundle: nil), forCellWithReuseIdentifier: "thanhvienimagecon")
//            return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCellCollectionViewCell", for: indexPath) as! VideoCellCollectionViewCell
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

extension AlbumvideoController: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: (UIScreen.main.bounds.width)/5.2 - 20, height: 200)
            }
        return CGSize(width: (UIScreen.main.bounds.width)/2.5-10, height: 200)
       
    }
}



