//
//  ChangerAvatarViewController.swift
//  FutureLove
//
//  Created by TTH on 09/08/2023.
//

import UIKit

class ChangerAvatarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a: [String] = [
            "http://example.com/image1.jpg",
            "http://example.com/image1.jpg",
            "http://example.com/image1.jpg"
        ]
        var b: [String: String] = [:]
        a.enumerated().forEach { index, value in
            b.updateValue(value, forKey: "\(index + 1)")
        }
        print(b)
    }


  

}
