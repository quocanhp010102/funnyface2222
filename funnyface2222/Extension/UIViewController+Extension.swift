

import UIKit
private let kHUDTag = 1234
private let kCustomeHUDTag = 1235

extension UIViewController {
    
    func presentSimpleAlert(title: String?,
                            message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    func presentSimpleAlert(title: String?,
                            message: String,
                            callback: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in callback()}))
        present(alert, animated: true)
    }
    
    func presentConfirmationAlert(title: String? = nil,
                                  message: String,
                                  okOption: String, cancelOption: String,
                                  okCallback: @escaping () -> Void,
                                  cancelCallback: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okOption,
                                      style: .default,
                                      handler: { _ in
            okCallback()
        }))
        alert.addAction(UIAlertAction(title: cancelOption,
                                      style: .cancel,
                                      handler: { _ in
            cancelCallback()
        }))
        present(alert, animated: true)
    }
  
    func showAlert(title: String,
                   message: String,
                   textOk: String,
                   okCallBack: @escaping() -> Void) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: textOk,
                                     style: .default,
                                     handler: { _ in
            okCallBack()
        })
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    internal var customeIndicator: LoadingView? {
        guard let tabbarController = UIApplication.shared.mainKeyWindow?.rootViewController else { return nil }
        let huds = tabbarController.view.subviews.reversed().compactMap { $0 as? LoadingView }
        return huds.first { $0.tag == kCustomeHUDTag }
    }
    
    func showCustomeIndicator(with title: String = "") {
        DispatchQueue.main.async { [weak self] in
            guard let sself = self, sself.customeIndicator == nil,
                  let tabbarController = UIApplication.shared.mainKeyWindow?.rootViewController else { return }
            let hud = LoadingView(title: title)
            hud.showAdded(to: tabbarController.view)
            hud.tag = kCustomeHUDTag
        }
    }
    
    func hideCustomeIndicator(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.customeIndicator?.hide(completion: completion)
        }
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
