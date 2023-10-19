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
        
        self.navigationController?.navigationBar.titleTextAttributes = Constant.BarButtonAttribute.title
        self.navigationController?.navigationBar.tintColor = Constant.Color.subColor
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        
    }
}
