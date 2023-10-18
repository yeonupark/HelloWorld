//
//  BaseViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarFont()
        configure()
        setConstraints()
    }
    
    func setNavigationBarFont() {
        guard let font = UIFont(name: Constant.FontName.bold, size: 18) else {
            return
        }
        let attributes = [NSAttributedString.Key.font: font]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        self.navigationController?.navigationBar.tintColor = Constant.Color.subColor
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        
    }
}
