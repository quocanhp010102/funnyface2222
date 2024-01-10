

import UIKit

extension UINavigationController {
    func push<T: UIViewController>(viewController vc: UIViewController,
                                   controllerType: T.Type,
                                   isAnimated: Bool = true,
                                   ishidesBottomBar: Bool = false) {
        guard let viewController = vc as? T else {
            fatalError("Could not instantiateViewController with identifier: \(controllerType)")
        }
        viewController.hidesBottomBarWhenPushed = ishidesBottomBar
        self.pushViewController(viewController, animated: isAnimated)
    }
    
    func setRootViewController<T: UIViewController>(viewController vc: UIViewController,
                                                    controllerType: T.Type,
                                                    isAnimated: Bool = true) {
        guard let window = UIApplication.shared.mainKeyWindow,
              let viewController = vc as? T else {
            fatalError("Could not instantiateViewController with identifier: \(controllerType)")
        }
        window.rootViewController = UINavigationController.init(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
}
