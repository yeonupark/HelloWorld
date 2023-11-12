//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit
import RealmSwift
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.appearance().setTitleTextAttributes(Constant.BarButtonAttribute.rightBarButton as [NSAttributedString.Key : Any], for: .normal)
        UILabel.appearance().font = UIFont(name: Constant.FontName.regular, size: 15)
        UILabel.appearance().textColor = Constant.Color.titleColor
        
        UITableViewCell.appearance().backgroundColor = .clear
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions, completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        let config = Realm.Configuration(schemaVersion: 10) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { }
            
            if oldSchemaVersion < 2 { } //
            
            if oldSchemaVersion < 3 { } // list<> 앞에 @Persisted 추가
            
            if oldSchemaVersion < 4 { }
            
            if oldSchemaVersion < 5 { }
            
            if oldSchemaVersion < 6 { } // endDate: Date? -> endDate: Date
            
            if oldSchemaVersion < 7 { } // numberOfImages 추가
            
            if oldSchemaVersion < 8 { } // placeName, latitude, longitude 추가
            
            if oldSchemaVersion < 9 { } // TodoTable, CostTable, LinkTable 수정
            
            if oldSchemaVersion < 10 { }
        }
        
        Realm.Configuration.defaultConfiguration = config
        FirebaseApp.configure()
        sleep(1)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
    }
}
