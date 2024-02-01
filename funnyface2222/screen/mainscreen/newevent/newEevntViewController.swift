//
//  newEevntViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 30/01/2024.
//

import UIKit
import Kingfisher

class newEevntViewController: UIViewController {
    @IBOutlet weak var coleccionTemplate:UICollectionView!
    @IBOutlet weak var coleccionVideo:UICollectionView!
    @IBOutlet weak var coleccionImaged:UICollectionView!
    @IBOutlet weak var imageviewtemplate:UIImageView!
    @IBOutlet weak var imageAvatar:UIImageView!
    var listTemplateVideo : [ResultVideoModel] = [ResultVideoModel]()
    var listImage:[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.shared.listImageUploaded(type:"video",idUser:String(AppConstant.userId ?? 0)){response,error in
            self.listImage = response
            self.coleccionImaged.reloadData()
        }
        coleccionTemplate.register(UINib(nibName: "newtemplate", bundle: nil), forCellWithReuseIdentifier: "newtemplate")
        coleccionVideo.register(UINib(nibName: "hightlightmain", bundle: nil), forCellWithReuseIdentifier: "hightlightmain")
        coleccionImaged.register(UINib(nibName: "ListImageCLVCell", bundle: nil), forCellWithReuseIdentifier: "ListImageCLVCell")


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
extension newEevntViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == coleccionTemplate {
            return 4
        }else if collectionView == coleccionImaged {
            return self.listImage.count
        }
        return self.listTemplateVideo.count
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if let parentVC = findParentViewController(of: UIViewController.self) {
        //                let nextViewController = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
        //                nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
        //            nextViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        //                parentVC.present(nextViewController, animated: true, completion: nil)
        //            }
        if collectionView == coleccionTemplate {
            if indexPath.row == 0 {
                if let image = UIImage(named: "template1") {
                            // Đặt ảnh cho UIImageView
                    self.imageviewtemplate.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else
            if indexPath.row == 1 {
                if let image = UIImage(named: "template2") {
                            // Đặt ảnh cho UIImageView
                    self.imageviewtemplate.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else
            if indexPath.row == 2 {
                if let image = UIImage(named: "Template3") {
                            // Đặt ảnh cho UIImageView
                    self.imageviewtemplate.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else
            if indexPath.row == 3 {
                if let image = UIImage(named: "template4") {
                            // Đặt ảnh cho UIImageView
                    self.imageviewtemplate.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }
        }
        else if collectionView == coleccionImaged {
            let url = URL(string:self.listImage[indexPath.row])
            let processor = DownsamplingImageProcessor(size: self.imageAvatar.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            self.imageAvatar.kf.indicatorType = .activity
                // cell.timeLabel.text = "Image " + String(indexPath.row)
            self.imageAvatar.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
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
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonimageclv", for: indexPath) as! cacluachonimageclv
//           // cell.labelNameCategori.text=listCategories[indexPath.row]
//
//
//        cell.thanhvienimagecon.register(UINib(nibName: "thanhvienimagecon", bundle: nil), forCellWithReuseIdentifier: "thanhvienimagecon")
//            return cell
        if collectionView == coleccionTemplate {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newtemplate", for: indexPath) as! newtemplate
            if indexPath.row == 0 {
                if let image = UIImage(named: "template1") {
                            // Đặt ảnh cho UIImageView
                    cell.imageView.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else if collectionView == coleccionImaged {
                
            }
                else
            if indexPath.row == 1 {
                if let image = UIImage(named: "template2") {
                            // Đặt ảnh cho UIImageView
                    cell.imageView.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else
            if indexPath.row == 2 {
                if let image = UIImage(named: "Template3") {
                            // Đặt ảnh cho UIImageView
                    cell.imageView.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }else
            if indexPath.row == 3 {
                if let image = UIImage(named: "template4") {
                            // Đặt ảnh cho UIImageView
                    cell.imageView.image = image
                        } else {
                            // Nếu không tìm thấy ảnh, bạn có thể cập nhật hoặc xử lý tùy thuộc vào yêu cầu của bạn
                            print("Không tìm thấy ảnh có tên template1 trong project.")
                        }
            }
            return cell
        }else if collectionView == coleccionImaged {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListImageCLVCell.className, for: indexPath) as! ListImageCLVCell
            let url = URL(string:self.listImage[indexPath.row])
            let processor = DownsamplingImageProcessor(size: cell.imageCover.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.imageCover.kf.indicatorType = .activity
            cell.timeLabel.text = "Image " + String(indexPath.row)
            cell.imageCover.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hightlightmain", for: indexPath) as! hightlightmain
        cell.imageVieww.layer.cornerRadius = 10
        cell.imageVieww.layer.masksToBounds = true
       // cell.labelTimeRun.text = "Time Swap: " + (self.listTemplateVideo[indexPath.row].thoigian_swap ?? "")
        cell.labels.text = self.listTemplateVideo[indexPath.row].thoigian_taosk ?? ""
//        if let url = URL(string: self.listTemplateVideo[indexPath.row].link_vid_swap ?? ""){
//            cell.imageVideo.image = getThumbnailImage(forUrl: url)
//        }
        let url = URL(string: self.listTemplateVideo[indexPath.row].link_image ?? "")
        let processor = DownsamplingImageProcessor(size: cell.imageVieww.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageVieww.kf.indicatorType = .activity
        cell.imageVieww.kf.setImage(
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
   
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension newEevntViewController: UICollectionViewDelegateFlowLayout {
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
        if collectionView == coleccionTemplate {
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: (UIScreen.main.bounds.width)/3.2 - 20, height: 200)
            }
        return CGSize(width: (UIScreen.main.bounds.width)/2-10, height: 200)
        }
        else {
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: (UIScreen.main.bounds.width)/3.2 - 20, height: 400)
            }
        return CGSize(width: (UIScreen.main.bounds.width)/2-10, height: 400)
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: (UIScreen.main.bounds.width)/3.2 - 20, height: 200)
        }
    return CGSize(width: (UIScreen.main.bounds.width)/2-10, height: 200)
       
    }
}

