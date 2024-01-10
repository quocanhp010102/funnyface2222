//
//  HowToUseVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/3/23.
//

import UIKit
import SETabView
import Vision
import Toast_Swift
import DeviceKit

class HowToUseVC: BaseViewController {
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonGood: UIButton!
    @IBOutlet weak var buttonBad: UIButton!
    @IBOutlet weak var buttonBack: UIButton!

    @IBOutlet weak var collectionViewGood: UICollectionView!
    @IBOutlet weak var collectionViewBad: UICollectionView!
    @IBOutlet weak var luonSong2Image: UIImageView!
    @IBOutlet weak var luonSongImage: UIImageView!
    
    var currentImageType: ChooseImageType = .boy
    var imageBoy:UIImage?
    var imageboyLink: String = ""
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonNext.setTitle("Next To Use App", for: .normal)
        buttonGood.setTitle("", for: .normal)
        buttonBad.setTitle("", for: .normal)
        buttonBack.setTitle("", for: .normal)
        buttonNext.layer.cornerRadius = 20
        buttonNext.clipsToBounds = true
        collectionViewGood.register(UINib(nibName: HowToCLVCell.className, bundle: nil), forCellWithReuseIdentifier: HowToCLVCell.className)
        collectionViewBad.register(UINib(nibName: HowToCLVCell.className, bundle: nil), forCellWithReuseIdentifier: HowToCLVCell.className)
        self.collectionViewGood.backgroundColor = UIColor(red: 211/225, green: 165/225, blue: 182/225, alpha: 1.0)
        self.collectionViewBad.backgroundColor = UIColor(red: 211/225, green: 165/225, blue: 182/225, alpha: 1.0)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        UIView.animate(withDuration: 2.0, animations: {
            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: 0)
                }) { _ in
                    self.luonSongImage.transform = CGAffineTransform(translationX: 0 , y: 0)
                }
        UIView.animate(withDuration: 3.0, animations: {
            self.luonSong2Image.transform = CGAffineTransform(translationX: -160 , y: 0)
                }) { _ in
                    self.luonSong2Image.transform = CGAffineTransform(translationX: 0 , y: 0)
                }
    }
    @objc func timerAction() {
        UIView.animate(withDuration: 2.0, animations: {
            self.luonSongImage.transform = CGAffineTransform(translationX: -150 , y: 0)
                }) { _ in
                    self.luonSongImage.transform = CGAffineTransform(translationX: 0 , y: 0)
                }
        UIView.animate(withDuration: 3.0, animations: {
            self.luonSong2Image.transform = CGAffineTransform(translationX: -160 , y: 0)
                }) { _ in
                    self.luonSong2Image.transform = CGAffineTransform(translationX: 0 , y: 0)
                }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextLoadImages(){
        self.navigationController?.popViewController(animated: false)
    }
}


extension HowToUseVC : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        textField.resignFirstResponder()
        return true
    }
}

extension HowToUseVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewBad{
            let vc = DetailHowToVC( )
            vc.imageLink = "loi-" + String(indexPath.row + 1)
            if indexPath.row == 0{
                vc.textMainPro = "Glasses are not allowed, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 1{
                vc.textMainPro = "Do not turn your back on the lens, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 2{
                vc.textMainPro = "Do not turn your back on the lens, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 3{
                vc.textMainPro = "You must not grimace or cover your face with your hands, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 4{
                vc.textMainPro = "Photos with unclear faces, photos of people practicing yoga, or photos that are too far away with unclear faces are also not accepted, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 5{
                vc.textMainPro = "It's not okay if you're sick, pale, or your face is different from usual, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }else if indexPath.row == 6{
                vc.textMainPro = "Do not cover your face or part of your face with your hands, we will not be able to get information from your face, You must choose a photo with a clear face, only one face, no mask, no glasses, no backlight, no makeup"
            }
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewGood{
            return 6
        }
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewGood{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HowToCLVCell.className, for: indexPath) as! HowToCLVCell
            cell.labelTitle.text = String(indexPath.row + 1)
            cell.imageCover.image = UIImage(named: "howto-" + String(indexPath.row + 1))
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HowToCLVCell.className, for: indexPath) as! HowToCLVCell
        cell.labelTitle.text = String(indexPath.row + 1)
        cell.imageCover.image = UIImage(named: "loi-" + String(indexPath.row + 1))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension HowToUseVC: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width/6 - 5, height: 130)
        }
        return CGSize(width: UIScreen.main.bounds.width/6 - 5, height: 130)
    }
}

