//
//  TabbarViewController.swift
//  FutureLove
//
//  Created by TTH on 25/07/2023.
//

import UIKit
import SETabView

class TabbarViewController: SETabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set tab bar look
        setTabColors(backgroundColor: .black,
                     ballColor: .white,
                     tintColor: .black,
                     unselectedItemTintColor: .white,
                     barTintColor: .clear)
        
        // set view controllers
        setViewControllers(getViewControllers())
    }
    
    private func getViewControllers() -> [UIViewController] {
       
           
        let storyboard = UIStoryboard(name: "HomeStaboad", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeMainView") as! HomeMainView
        
        let storyboardd = UIStoryboard(name: "mhchinh", bundle: nil)
        let controller2 = storyboardd.instantiateViewController(withIdentifier: "mhtestViewController") as! mhtestViewController
        let controller3 = storyboardd.instantiateViewController(withIdentifier: "mhchinhController") as! mhchinhController
    let controller4 = ProfileViewController()
        controller4.userId = Int(AppConstant.userId.asStringOrEmpty()) ?? 0
        ProfileViewController().userId = Int(AppConstant.userId.asStringOrEmpty()) ?? 0
           return [
            controller,
            controller2,
            controller3,
            CommentsViewController(),
            controller4
           ]
//        return [
//            let storyboard = UIStoryboard(name: "mainpage", bundle: nil)
//            HomeMainView(nibName: "HomeMainView", bundle: nil),
//            mhtestViewController(nibName: "mhtestViewController", bundle: nil),
//            CommentsViewController(nibName: "CommentsViewController", bundle: nil),
//            LoveViewController(nibName: "LoveViewController", bundle: nil),
//        ]
    }


}
