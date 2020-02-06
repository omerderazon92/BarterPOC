//
//  SceneDelegate.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let mainVC = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        mainVC.presenter = FeedPresenter()
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.presenter = SearchPresenter()
        let addItemVC = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "AddItemViewController")) 
        let winningVC = storyboard.instantiateViewController(withIdentifier: "WinningPickItemViewController")
        
        let mainVCTabBarItem = UITabBarItem()
        mainVCTabBarItem.image = UIImage(imageLiteralResourceName: "feed")
        mainVCTabBarItem.title = "פיד"
        mainVC.tabBarItem = mainVCTabBarItem
        
        let searchVCTabBarItem = UITabBarItem()
        searchVCTabBarItem.image = UIImage(imageLiteralResourceName: "search")
        searchVCTabBarItem.title = "חיפוש"
        searchVC.tabBarItem = searchVCTabBarItem
        
        let addItemVCTabBarItem = UITabBarItem()
        addItemVCTabBarItem.image = UIImage(imageLiteralResourceName: "add")
        addItemVCTabBarItem.title = "הוסף"
        addItemVC.tabBarItem = addItemVCTabBarItem
        
        let winningPickItemTabBar = UITabBarItem()
        winningPickItemTabBar.image = UIImage(imageLiteralResourceName: "my_presents")
        winningPickItemTabBar.title = "המתנות שלך"
        winningVC.tabBarItem = winningPickItemTabBar
        winningPickItemTabBar.badgeValue = "2"
        winningPickItemTabBar.badgeColor = .systemRed
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC, searchVC, addItemVC, winningVC]
        tabBarController.selectedViewController = mainVC
        tabBarController.selectedIndex = 0
        
        window!.rootViewController = tabBarController

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

