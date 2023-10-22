//
//  TabBarController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        setTabBar()
        setTapBarFont()
    }
    
    func setTabBar() {
        
        tabBar.tintColor = Constant.Color.subColor
        tabBar.isTranslucent = true
        tabBar.backgroundColor = Constant.Color.backgroundColor
        
        
        let agendaTabBarItem = UITabBarItem(title: "계획", image: resizeImage(image: UIImage(named: "NoteImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 0)
        let worldMapTabBarItem = UITabBarItem(title: "날씨 및 시간", image: resizeImage(image: UIImage(named: "EarthImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 1)
        let exchangeRateTabBarItem = UITabBarItem(title: "환율 계산", image: resizeImage(image: UIImage(named: "DollarImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 2)
        
        for item in [agendaTabBarItem, worldMapTabBarItem, exchangeRateTabBarItem] {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15)
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        }
        
        let agendaTab = UINavigationController(rootViewController: MyTravelViewController())
        agendaTab.tabBarItem = agendaTabBarItem
        
        let worldMapTab = UINavigationController(rootViewController: WorldMapViewController())
        worldMapTab.tabBarItem = worldMapTabBarItem
        
        let exchangeRateTab = UINavigationController(rootViewController: ExchangeRateViewController())
        exchangeRateTab.tabBarItem = exchangeRateTabBarItem
        
        viewControllers = [agendaTab, worldMapTab, exchangeRateTab]
        
    }
    
    func setTapBarFont() {
        guard let font = UIFont(name: Constant.FontName.regular, size: 12) else {
            return
        }
        let attributes = [NSAttributedString.Key.font: font]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage.withRenderingMode(image.renderingMode)
    }

}
