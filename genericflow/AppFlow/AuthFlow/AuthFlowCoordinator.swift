protocol AuthFlowCoordinator: Coordinator {

  var onCompletion: Completion { get set }

}

final class AuthFlowCoordinatorImpl: BaseCoordinator, AuthFlowCoordinator {

  var onCompletion = {}

  override func start() {
    showSignIn()
  }

  private func showSignIn() {
    var module = assembler.resolver.resolve(SignInModule.self)!
    module.onSignedIn = { [weak self] in
      self?.onCompletion()
    }
    module.onRegisterTap = { [weak self] in
      self?.showRegistration()
    }
    router.setRootModule(module)
  }

  private func showRegistration() {
    var module = assembler.resolver.resolve(RegistrationModule.self)!
    module.onRegistered = { [weak self] in
      self?.onCompletion()
    }
    router.push(module)
  }

}
