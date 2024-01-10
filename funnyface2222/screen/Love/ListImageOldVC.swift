//
//  ListImageOldVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/30/23.
//

import UIKit
import SwiftKeychainWrapper
import Kingfisher



class ListImageOldVC: UIViewController {
    @IBOutlet weak var collectionViewGood: UICollectionView!
    @IBOutlet weak var buttonBack: UIButton!
    var type:String = ""
    var listImage:[String] = [String]()
    @IBAction func backAppPro(){
        self.dismiss(animated: true)
    }
    
    func loadAllImagesUpload(){
        APIService.shared.listImageUploaded(type:self.type,idUser:String(AppConstant.userId ?? 0)){response,error in
            self.listImage = response
            self.collectionViewGood.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBack.setTitle("", for: .normal)
        self.collectionViewGood.backgroundColor = UIColor.clear
        collectionViewGood.register(UINib(nibName: ListImageCLVCell.className, bundle: nil), forCellWithReuseIdentifier: ListImageCLVCell.className)
        loadAllImagesUpload()
        
    }
}
extension ListImageOldVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDataDict:[String: String] = ["image": listImage[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Notification_SEND_IMAGES"), object: nil, userInfo: imageDataDict)
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension ListImageOldVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width/4 - 10, height: 300)
        }
        return CGSize(width: UIScreen.main.bounds.width/2 - 10, height: 300)
    }
}

