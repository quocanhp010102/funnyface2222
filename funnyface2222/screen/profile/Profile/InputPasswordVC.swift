//
//  InputPasswordVC.swift
//  FutureLove
//
//  Created by khongtinduoc on 10/17/23.
//

import UIKit

class InputPasswordVC: UIViewController ,UITextFieldDelegate{

    @IBOutlet private weak var nameTextField: UITextField!
    
    var didSendData: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func handleCloseButtonTapped(_ sender: Any) {
        if let passwordSend = nameTextField.text {
            //             didSendData?(name)
            APIService.shared.RemoveMyAccount(userID: String(AppConstant.userId ?? 0 ), password: passwordSend){response,error in
                if response.contains("Successfully") == true{ // Successfully deleted account with id = 42
                    AppConstant.logout()
                    let alert = UIAlertController(title: "Remove Account", message: response, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okie Signout", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            return
                        case .cancel:
                            self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            return
                        case .destructive:
                            self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            return
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                let alert = UIAlertController(title: "Remove Account", message: response, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okie", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        //dismiss(animated: true)
    }

}
