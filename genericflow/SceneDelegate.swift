//
//  SceneDelegate.swift
//  genericflow
//
//  Created by Dulat on 26.11.2022.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator!

  private func createAppCoordinator(window: UIWindow) -> AppCoordinator {
    let assembler = Assembler([AppCoordinatorAssembly()])
    let coordinator = assembler.resolver.resolve(AppCoordinator.self, argument: assembler)!
    coordinator.set(window: window)
    coordinator.start()
    return coordinator
  }


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    appCoordinator = createAppCoordinator(window: window)
    self.window = window
    window.backgroundColor = .white
    window.makeKeyAndVisible()
  }

}

