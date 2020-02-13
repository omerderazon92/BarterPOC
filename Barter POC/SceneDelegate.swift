//
//  SceneDelegate.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let myItemsTabBarItem = UITabBarItem()
    let myItemsPresenter = MyItemsPresenter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let mainVC = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        mainVC.presenter = FeedPresenter()
        let mainVCNav = UINavigationController(rootViewController: mainVC)
        
        let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.presenter = SearchPresenter()
        let searchVCNav = UINavigationController(rootViewController: searchVC)

        let addItemVC = storyboard.instantiateViewController(withIdentifier: "AddItemViewController")
        let addItemVCNav = UINavigationController(rootViewController: addItemVC)
        
        let winningVC = storyboard.instantiateViewController(withIdentifier: "WinningPickItemViewController")
        
        let myItemsVC = storyboard.instantiateViewController(identifier: "MyItemsViewController") as! MyItemsViewController
        myItemsVC.presenter = myItemsPresenter
        let myItemsVCNav = UINavigationController(rootViewController: myItemsVC)
        
        let mainVCTabBarItem = UITabBarItem()
        mainVCTabBarItem.image = UIImage(imageLiteralResourceName: "feed")
        mainVCTabBarItem.title = "עבורך"
        mainVC.tabBarItem = mainVCTabBarItem
        
        let searchVCTabBarItem = UITabBarItem()
        searchVCTabBarItem.image = UIImage(imageLiteralResourceName: "search")
        searchVCTabBarItem.title = "חיפוש"
        searchVC.tabBarItem = searchVCTabBarItem
        
        let addItemVCTabBarItem = UITabBarItem()
        addItemVCTabBarItem.image = UIImage(imageLiteralResourceName: "add")
        addItemVCTabBarItem.title = "הוסף"
        addItemVC.tabBarItem = addItemVCTabBarItem
        
        let winningPickItemTabBarItem = UITabBarItem()
        winningPickItemTabBarItem.image = UIImage(imageLiteralResourceName: "my_presents")
        winningPickItemTabBarItem.title = "המתנות שלך"
        winningVC.tabBarItem = winningPickItemTabBarItem
        winningPickItemTabBarItem.badgeValue = "2"
        winningPickItemTabBarItem.badgeColor = .systemRed
        
        myItemsTabBarItem.image = UIImage(imageLiteralResourceName: "storage")
        myItemsTabBarItem.title = "פריטיי"
        myItemsVCNav.tabBarItem = myItemsTabBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVCNav, searchVCNav, addItemVCNav, myItemsVCNav]
        tabBarController.selectedViewController = mainVCNav
        tabBarController.selectedIndex = 0
        
        window!.rootViewController = tabBarController
         IQKeyboardManager.shared.enable = true
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
        let numberOfCurrentOffers = myItemsPresenter.fetchNumberOfCurrentOffers()
        myItemsTabBarItem.badgeColor = .systemRed
        myItemsTabBarItem.badgeValue = numberOfCurrentOffers > 0 ? numberOfCurrentOffers.description : nil
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

