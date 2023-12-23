//
//  TabBarController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setTapBarFont()
    }
    
    func setTabBar() {
        let customTabBar = CustomTabBar()
        
        customTabBar.tintColor = Constant.Color.subColor
        customTabBar.isTranslucent = true
        customTabBar.backgroundColor = Constant.Color.backgroundColor
        
        let agendaTabBarItem = UITabBarItem(title: NSLocalizedString("agenda_tapBarTitle", comment: ""), image: resizeImage(image: UIImage(named: "NoteImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 0)
        let worldMapTabBarItem = UITabBarItem(title: NSLocalizedString("weather_tapBarTitle", comment: ""), image: resizeImage(image: UIImage(named: "EarthImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 1)
        let exchangeRateTabBarItem = UITabBarItem(title: NSLocalizedString("exchangeRate_tapBarTitle", comment: ""), image: resizeImage(image: UIImage(named: "DollarImage")!, targetSize: CGSize(width: 30, height: 30)), tag: 2)
        
        for item in [agendaTabBarItem, worldMapTabBarItem, exchangeRateTabBarItem] {
            if UIScreen.main.bounds.height <= 667 {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -25, right: 0)
            }
        }
        
        let agendaTab = UINavigationController(rootViewController: MyTravelViewController())
        agendaTab.tabBarItem = agendaTabBarItem
        
        let worldMapTab = UINavigationController(rootViewController: WorldMapViewController())
        worldMapTab.tabBarItem = worldMapTabBarItem
        
        let exchangeRateTab = UINavigationController(rootViewController: ExchangeRateViewController())
        exchangeRateTab.tabBarItem = exchangeRateTabBarItem
        
        viewControllers = [agendaTab, worldMapTab, exchangeRateTab]
        
        self.setValue(customTabBar, forKey: "tabBar")
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

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 75
        return sizeThatFits
    }
}
