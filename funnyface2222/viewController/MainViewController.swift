//
//  MainViewController.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 05/01/2024.
//

import UIKit
import DeviceKit
class MainViewController: UIViewController {
    
    @IBAction func btnGoLogin(_ sender: Any) {
        print("hello")
        let storyboard = UIStoryboard(name: "login", bundle: nil) // type storyboard name instead of Main
         if let myViewController = storyboard.instantiateViewController(withIdentifier: "loginView") as? loginView {
             myViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
               present(myViewController, animated: true, completion: nil)
         }
      
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let device = Device.current
        let modelName = device.description
        AppConstant.modelName = modelName
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            if AppConstant.userId == nil {
                //                        self.navigationController?.pushViewController(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true)
                let storyboard = UIStoryboard(name: "login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "loginView") as! loginView
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
            } else {
                //                        self.navigationController?.setRootViewController(viewController: MainSwapfaceViewController(),
                //                                                                         controllerType: MainSwapfaceViewController.self)
//                let storyboard = UIStoryboard(name: "mainpage", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "mhthunhat") as! mhthunhat
//                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//                self.present(vc, animated: true, completion: nil)
                
                let vc = TabbarViewController()
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
            }
            
        }
    }


}

