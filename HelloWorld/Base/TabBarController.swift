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
    }
    
    func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false
        
        let agendaTab = UINavigationController(rootViewController: MyTravelViewController())
        let agendaTabBarItem = UITabBarItem(title: "계획", image: UIImage(systemName: "note.text"), tag: 0)
        agendaTab.tabBarItem = agendaTabBarItem
        
        let worldMapTab = UINavigationController(rootViewController: WorldMapViewController())
        let worldMpTabBarItem = UITabBarItem(title: "날씨 및 시간", image: UIImage(systemName: "globe.asia.australia.fill"), tag: 1)
        worldMapTab.tabBarItem = worldMpTabBarItem
        
        viewControllers = [agendaTab, worldMapTab]
        
    }
}
