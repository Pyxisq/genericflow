import Swinject

struct SignInModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(SignInModule.self) { resolver in
      let emailValidationService = resolver.resolve(EmailValidationService.self)!
      let passwordValidationService = resolver.resolve(PasswordValidationService.self)!
      let loginService = resolver.resolve(LoginService.self)!

      let viewModel = SignInViewModel(
        emailValidationService: emailValidationService,
        passwordValidationService: passwordValidationService,
        loginService: loginService
      )

      let viewController = SignInViewController()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
