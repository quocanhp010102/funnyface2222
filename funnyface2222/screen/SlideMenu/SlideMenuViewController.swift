//
//  SlideMenuViewController.swift
//  FutureLove
//
//  Created by TTH on 28/07/2023.
//

import UIKit

protocol SlideMenuprotocol: AnyObject {
    func navigateDetailComment(at index: Int, dataEvent: EventModel)
    func navigeteHome()
}

class SlideMenuViewController: UIViewController {
    weak var delegate: SlideMenuprotocol?
    var data : [EventModel]
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var slideMenuTableView: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    init(data: [EventModel]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuTableView.delegate = self
        slideMenuTableView.dataSource = self
        slideMenuTableView.register(cellType: SlideMenuTableViewCell.self)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.delegate?.navigeteHome()
    }
    
    @IBAction func addEventBtn(_ sender: Any) {
        
    }
    
    @IBAction func DismisBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    
}

// MARK: - extension UITableView
extension SlideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SlideMenuTableViewCell", for: indexPath) as? SlideMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(model: data[indexPath.row])
        return cell
        
        
    }
}

extension SlideMenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.navigateDetailComment(at: indexPath.row, dataEvent: data[indexPath.row])
    }
}
