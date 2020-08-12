//
//  SceneDelegate.swift
//  JsonGitHubTest
//
//  Created by Кирилл on 18.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        let builder = ModelBuilder()
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assamblyBilder: builder)
        router.mainViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
