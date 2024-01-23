//
//  MainViewController.swift
//  funnyfaceisoproject
//
//  Created by quocanhppp on 05/01/2024.
//

import UIKit

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
    }


}

