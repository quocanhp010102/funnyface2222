//
//  stoaboadpagemain.swift
//  funnyface2222
//
//  Created by quocanhppp on 22/01/2024.
//

//
//  StoryboardPageTabMenuViewController.swift
//  PageMenuExample
//
//  Created by Tamanyan on 9/3/31 H.
//  Copyright © 31 Heisei Tamanyan. All rights reserved.
//

import UIKit
import Swift_PageMenu



class stoaboadpagemain: PageMenuController {

    let items: [[String]]

    let titles: [String]

    let icons: [UIImage]
    init(items: [[String]], titles: [String], icons: [UIImage] , options: PageMenuOptions? = nil) {
        self.items = items
        self.titles = titles
        self.icons = icons
        super.init(options: options)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []

        if options.layout == .layoutGuide && options.tabMenuPosition == .bottom {
            
            self.view.backgroundColor = .yellow
        } else {
           // self.options.tabMenuBackgroundColor = .black
            self.view.backgroundColor = .black
        }

        if self.options.tabMenuPosition == .custom {
            self.view.addSubview(self.tabMenuView)
            self.tabMenuView.translatesAutoresizingMaskIntoConstraints = false

            self.tabMenuView.heightAnchor.constraint(equalToConstant: self.options.menuItemSize.height).isActive = true
            self.tabMenuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.tabMenuView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            if #available(iOS 11.0, *) {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            }
        }

        self.delegate = self
        self.dataSource = self
    }
}

extension stoaboadpagemain: PageMenuControllerDataSource {
    
    
    func viewControllers(forPageMenuController pageMenuController: PageMenuController) -> [UIViewController] {
        return self.titles.enumerated().map({ (i, title) -> UIViewController in
            if i == 0 {
                let storyboard = UIStoryboard(name: "HomeStaboad", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "HomeMainView") as! HomeMainView

                controller.title = "Storyboard #\(i) (\(title))"
                
                return controller
            }else if i == 1 {
                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "mhtestViewController") as! mhtestViewController

                controller.title = "Storyboard #\(i) (\(title))"
                //ImageMainViewController
                return controller
            }
            else if i == 2 {
              
                let controller = CommentsViewController()

                controller.title = "Storyboard #\(i) (\(title))"
                //ImageMainViewController
                return controller
            }
            else if i == 4 {
              
                let controller = ProfileViewController()
                controller.userId = Int(AppConstant.userId.asStringOrEmpty()) ?? 0
                controller.title = "Storyboard #\(i) (\(title))"
                //ImageMainViewController
                return controller
            }
            print(i)
            let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "testViewController") as! testViewController

            controller.title = "Storyboard #\(i) (\(title))"

            //controller.lable?.text = "àdfdsfsd"
            return controller
        })
    }

    func menuTitles(forPageMenuController pageMenuController: PageMenuController) -> [String] {
        return self.titles
    }

    func defaultPageIndex(forPageMenuController pageMenuController: PageMenuController) -> Int {
        return 1
    }
}

extension stoaboadpagemain: PageMenuControllerDelegate {
    func pageMenuController(_ pageMenuController: PageMenuController, didScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        // The page view controller will begin scrolling to a new page.
        print("didScrollToPageAtIndex index:\(index)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, willScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        // The page view controller scroll progress between pages.
        print("willScrollToPageAtIndex index:\(index)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, scrollingProgress progress: CGFloat, direction: PageMenuNavigationDirection) {
        // The page view controller did complete scroll to a new page.
        print("scrollingProgress progress: \(progress)")
    }

    func pageMenuController(_ pageMenuController: PageMenuController, didSelectMenuItem index: Int, direction: PageMenuNavigationDirection) {
        print("didSelectMenuItem index: \(index)")
    }
}

