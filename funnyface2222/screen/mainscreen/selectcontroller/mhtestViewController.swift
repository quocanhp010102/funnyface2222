//
//  mhtestViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit
import Swift_PageMenu
import SETabView
struct RoundRectPagerOption: PageMenuOptions {

    var isInfinite: Bool = false
    var selectedTab: Int = 0 // Add a variable to track the selected tab

    var tabMenuPosition: TabMenuPosition = .top

    var menuItemSize: PageMenuItemSize {
        return .sizeToFit(minWidth: 80, height: 30)
    }

    var menuTitleColor: UIColor {
        return selectedTab == 0 ? .white : .black
    }

    var menuTitleSelectedColor: UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

    }

    var menuCursor: PageMenuCursor {
        return .roundRect(
            rectColor: .green,
            cornerRadius: 10,
            height: 22,
            borderWidth: 1.0,  // Specify the desired border width
            borderColor: .black  // Specify the desired border color
        )
    }

    var font: UIFont {
        return .systemFont(ofSize: UIFont.systemFontSize)
    }

    var menuItemMargin: CGFloat {
        return 8
    }

    var tabMenuBackgroundColor: UIColor {
        return selectedTab == 0 ? .black : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

    }

    var tabMenuContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }

    public init(isInfinite: Bool = false, tabMenuPosition: TabMenuPosition = .top) {
        self.isInfinite = isInfinite
        self.tabMenuPosition = tabMenuPosition
    }
}


class mhtestViewController: UIViewController,SETabItemProvider {
    @IBOutlet weak var viewMain: UIView!

    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: R.image.tab_video(), tag: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let items: [[String]] = [
                    ["Item1A", "Item1B", "Item1C"],
                    ["Item2A", "Item2B", "Item2C"],
                    ["Item3A", "Item3B", "Item3C"]
                ]
                let titles: [String] = ["Videos", "Images", "Events","Love","Baby"]
        let customOptions = RoundRectPagerOption(isInfinite: false, tabMenuPosition: .top)
        
                // Khởi tạo StoryboardPageTabMenuViewController với các items và titles
                let pageMenuViewController = StoryboardPageTabMenuViewController(items: items, titles: titles, options: customOptions)

                // Thêm StoryboardPageTabMenuViewController làm con của parent view controller
                addChild(pageMenuViewController)
                viewMain.addSubview(pageMenuViewController.view)
                pageMenuViewController.didMove(toParent: self)

                // Cấu hình constraints cho StoryboardPageTabMenuViewController
                pageMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    pageMenuViewController.view.topAnchor.constraint(equalTo: viewMain.topAnchor),
                    pageMenuViewController.view.leadingAnchor.constraint(equalTo: viewMain.leadingAnchor),
                    pageMenuViewController.view.trailingAnchor.constraint(equalTo: viewMain.trailingAnchor),
                    pageMenuViewController.view.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor)
                ])
        // Do any additional setup after loading the view.
    }
    
}
