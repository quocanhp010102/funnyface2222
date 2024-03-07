//
//  testViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit
import SETabView
class testViewController: UIViewController,SETabItemProvider {
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "haha", image: UIImage(named: "notification"), tag: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
