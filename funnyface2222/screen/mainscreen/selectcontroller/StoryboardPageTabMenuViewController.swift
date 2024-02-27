//
//  StoryboardPageTabMenuViewController.swift
//  PageMenuExample
//
//  Created by Tamanyan on 9/3/31 H.
//  Copyright © 31 Heisei Tamanyan. All rights reserved.
//

import UIKit
import Swift_PageMenu



class StoryboardPageTabMenuViewController: PageMenuController {

    let items: [[String]]

    let titles: [String]

    init(items: [[String]], titles: [String], options: PageMenuOptions? = nil) {
        self.items = items
        self.titles = titles
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

extension StoryboardPageTabMenuViewController: PageMenuControllerDataSource {
    func viewControllers(forPageMenuController pageMenuController: PageMenuController) -> [UIViewController] {
        return self.titles.enumerated().map({ (i, title) -> UIViewController in
            if i == 0 {
                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "mhchinhController") as! mhchinhController

                controller.title = "Storyboard #\(i) (\(title))"
                
                return controller
            }else if i == 1 {
                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "ImageMainViewController") as! ImageMainViewController

                controller.title = "Storyboard #\(i) (\(title))"
                //ImageMainViewController
                return controller
            }else if i == 2 {
                let vc = EventView(nibName: "EventView", bundle: nil)
              
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
//                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "ImageMainViewController") as! ImageMainViewController
//
//                controller.title = "Storyboard #\(i) (\(title))"
//                //ImageMainViewController
                return vc
            }
            
            else if i == 3 {
                let vc = LoveViewController(nibName: "LoveViewController", bundle: nil)
              
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
//                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "ImageMainViewController") as! ImageMainViewController
//
//                controller.title = "Storyboard #\(i) (\(title))"
//                //ImageMainViewController
                return vc
            }
            else if i == 4 {
                let vc = babycenter(nibName: "babycenter", bundle: nil)
              
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
//                let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "ImageMainViewController") as! ImageMainViewController
//
//                controller.title = "Storyboard #\(i) (\(title))"
//                //ImageMainViewController
                return vc
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
        return 0
    }
}

extension StoryboardPageTabMenuViewController: PageMenuControllerDelegate {
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
