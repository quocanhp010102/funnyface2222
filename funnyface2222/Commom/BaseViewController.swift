
import UIKit

class BaseViewController: UIViewController {
    private var navColor: UIColor = .white
    private var isShowUnderLineColor: Bool = true
    private let rightButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Setup UI
    func setupUI() {
    }
    
    // MARK: - Navigation Bar
    func hideNavigationBar(isHide: Bool = true) {
        self.navigationController?.navigationBar.isHidden = isHide
        if !isHide {
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    func setupNavigationBar(titleView: UIView,
                            navColor: UIColor = .white,
                            titleLeftItem: String = "",
                            isShowUnderLineColor: Bool = true) {
        self.isShowUnderLineColor = isShowUnderLineColor
        self.navigationItem.titleView = titleView
        self.navColor = navColor
        setupNavigationBarColor(navColor: navColor)
        addLeftBarItem(imageName: UIImage(named: ""),
                       selectedImage: UIImage(named: ""),
                       title: titleLeftItem)
    }
    
    private func setupNavigationBarColor(navColor: UIColor) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let underLineColor = navColor
        let underLineImage = isShowUnderLineColor ? underLineColor.as1ptImage(height: 4) : UIColor.clear.as1ptImage(height: 4)
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navColor
            appearance.shadowImage = underLineImage
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        } else {
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.shadowImage = underLineImage
            navigationBar.backgroundColor = navColor
        }
    }
    
    func addLeftBarItem(imageName: UIImage?, selectedImage: UIImage?, title: String) {
        let leftButton = UIButton.init(type: UIButton.ButtonType.custom)
        leftButton.isExclusiveTouch = true
        leftButton.isSelected       = false
        leftButton.frame            = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        leftButton.addTarget(self,
                             action: #selector(tappedLeftBarButton(sender:)),
                             for: UIControl.Event.touchUpInside)
        
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        leftButton.setImage(imageName, for: UIControl.State.normal)
        leftButton.setImage(selectedImage, for: UIControl.State.selected)
        leftButton.setTitle(" \(title)", for: UIControl.State.normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
    }
    
    func removeLeftBarButton() {
        self.isShowUnderLineColor = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init()
    }
    
    // MARK: - NavigationBar Action
    @objc func tappedLeftBarButton(sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupDarkMode() {
        setupNavigationBarColor(navColor: navColor)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupDarkMode()
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        setupDarkMode()
    }
}
