//
//  ImageMainViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit

class ImageMainViewController: UIViewController {
    @IBOutlet weak var cacluachonimageclv:UICollectionView!
    @IBAction func swapnext(){
        if let parentVC = findParentViewController(of: UIViewController.self) {
                let nextViewController = SwapImageAlbum(nibName: "SwapImageAlbum", bundle: nil)
               // nextViewController.itemLink = self.listTemplateVideo[indexPath.row]
                
                parentVC.present(nextViewController, animated: true, completion: nil)
            }
    }
    var listData:[ListVideoModal] = [ListVideoModal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        cacluachonimageclv.register(UINib(nibName: "cacluachonimageclv", bundle: nil), forCellWithReuseIdentifier: "cacluachonimageclv")
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
extension ImageMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
            return 5
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewMainImage") as! ViewMainImage
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        print("lisssss dataa")
        print(self.listData)
        APIService.shared.GetListImages(albuum:"\(indexPath.row + 1)") { (response, error) in
            if let listData2 = response{
              
              
                DispatchQueue.main.async {
                    print(listData2)
                    vc.listData = listData2
                    print(vc.listData)
                    self.present(vc, animated: true, completion: nil)
                   
                }
            }
            
        }
      print("vc. list")
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cacluachonimageclv", for: indexPath) as! cacluachonimageclv
           // cell.labelNameCategori.text=listCategories[indexPath.row]
       
        APIService.shared.GetListImages(albuum:"\(indexPath.row + 1)") { (response, error) in
            if let listData = response{
              
              
                DispatchQueue.main.async {
                    cell.listData = listData
                    cell.thanhvienimagecon.reloadData()
                }
            }
            
        }
        cell.thanhvienimagecon.register(UINib(nibName: "thanhvienimagecon", bundle: nil), forCellWithReuseIdentifier: "thanhvienimagecon")
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension ImageMainViewController: UICollectionViewDelegateFlowLayout {
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



