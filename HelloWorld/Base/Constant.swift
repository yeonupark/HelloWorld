//
//  Constant.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/19.
//

import UIKit

enum Constant {
    
    enum FontName {
        static let bold = "GimpoGothicBold"
        static let regular = "GimpoGothicRegular"
    }
    
    enum Color {
        static let mainColor = UIColor(named: "MainColor")
        static let subColor = UIColor(named: "StarFishColor")
    }
    
    enum BarButtonAttribute {
        static let title = [NSAttributedString.Key.font: UIFont(name: Constant.FontName.bold, size: 18)]
        static let rightBarButton = [NSAttributedString.Key.font: UIFont(name: Constant.FontName.regular, size: 15)]
    }
}
