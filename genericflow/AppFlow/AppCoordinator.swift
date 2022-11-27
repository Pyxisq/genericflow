//
//  AppCoordinator.swift
//  CoordinatorsBasedOnViewControllers
//
//  Created by Dulat Bulat on 23.06.2021.
//

import UIKit

protocol AppCoordinator: Coordinator {

  func set(window: UIWindow)
}

final class AppCoordinatorImpl: BaseCoordinator, AppCoordinator {

  func set(window: UIWindow) {
    window.rootViewController = toPresent()
  }

  override func start() {
    showAuth()
  }

  private func showAuth() {
    let coordinator = assembler.resolver.resolve(AuthFlowCoordinator.self, argument: assembler)!
    coordinator.onCompletion = { [weak self] in
      self?.showMain()
    }
    coordinator.start()
    router.setRootModule(coordinator)
  }

  func showMain() {
    let coordinator = assembler.resolver.resolve(MainCoordinator.self, argument: assembler)!
    coordinator.start()
    router.setRootModule(coordinator)
  }
}
