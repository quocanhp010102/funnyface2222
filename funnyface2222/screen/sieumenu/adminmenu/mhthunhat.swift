//
//  mhthunhat.swift
//  funnyface2222
//
//  Created by quocanhppp on 22/01/2024.
//

//
//  mhtestViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit
import Swift_PageMenu
struct RoundRectPagerOption2: PageMenuOptions {

    var isInfinite: Bool = false
    var selectedTab: Int = 0 // Add a variable to track the selected tab

    var tabMenuPosition: TabMenuPosition = .bottom

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

    public init(isInfinite: Bool = false, tabMenuPosition: TabMenuPosition = .bottom) {
        self.isInfinite = isInfinite
        self.tabMenuPosition = tabMenuPosition
    }
}

class mhthunhat: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let items: [[String]] = [
                    ["Item1A", "Item1B", "Item1C"],
                    ["Item2A", "Item2B", "Item2C"],
                    ["Item3A", "Item3B", "Item3C"]
                ]
                let titles: [String] = ["hamg1", "hang2", "hang3","hang4","hang5"]
        let icons: [UIImage] = [
            UIImage(named: "home")!,
            UIImage(named: "library")!,
            UIImage(named: "comment")!,
            UIImage(named: "notification")!,
            UIImage(named: "profile")!
        ]
        let customOptions = RoundRectPagerOption2(isInfinite: false, tabMenuPosition: .bottom)
        
                // Khởi tạo StoryboardPageTabMenuViewController với các items và titles
        let pageMenuViewController = stoaboadpagemain(items: items, titles: titles, icons: icons ,options: customOptions)

                // Thêm StoryboardPageTabMenuViewController làm con của parent view controller
                addChild(pageMenuViewController)
                view.addSubview(pageMenuViewController.view)
                pageMenuViewController.didMove(toParent: self)

                // Cấu hình constraints cho StoryboardPageTabMenuViewController
                pageMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    pageMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                    pageMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    pageMenuViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    pageMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
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
