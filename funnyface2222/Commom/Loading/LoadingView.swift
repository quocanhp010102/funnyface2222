//
//  LoadingView.swift
//  FunPik
//
//  Created by Tran Van Dinh on 3/4/21.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    var spinner = UIActivityIndicatorView(style: .large)
    let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepare() {
        backgroundColor = .white.withAlphaComponent(0.7)
        spinner.color = .white
        
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
    func showAdded(to view: UIView) {
        view.addSubview(self)
        self.frame = view.bounds
        spinner.startAnimating()
        
    }
    
    func hide(completion: (() -> Void)? = nil) {
        spinner.stopAnimating()
        self.removeFromSuperview()
    }
}
