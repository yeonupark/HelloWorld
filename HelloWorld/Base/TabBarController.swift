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
        
        let agendaTab = UINavigationController(rootViewController: MyTravelViewController())
        let agendaTabBarItem = UITabBarItem(title: "계획", image: UIImage(systemName: "note.text"), tag: 0)
        agendaTab.tabBarItem = agendaTabBarItem
        
        let worldMapTab = UINavigationController(rootViewController: WorldMapViewController())
        let worldMapTabBarItem = UITabBarItem(title: "날씨 및 시간", image: UIImage(systemName: "globe.asia.australia.fill"), tag: 1)
        worldMapTab.tabBarItem = worldMapTabBarItem
        
        let exchangeRateTab = UINavigationController(rootViewController: ExchangeRateViewController())
        let exchangeRateTabBarItem = UITabBarItem(title: "환율 계산", image: UIImage(systemName: "dollarsign.arrow.circlepath"), tag: 2)
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
}
