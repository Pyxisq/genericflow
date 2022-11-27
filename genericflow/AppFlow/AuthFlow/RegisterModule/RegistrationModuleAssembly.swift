import Swinject

struct RegistrationModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(RegistrationModule.self) { resolver in
      let emailValidationService = resolver.resolve(EmailValidationService.self)!
      let passwordValidationService = resolver.resolve(PasswordValidationService.self)!
      let ageValidationService = resolver.resolve(AgeValidationService.self)!
      let loginService = resolver.resolve(LoginService.self)!

      let viewModel = RegistrationViewModel(
        emailValidationService: emailValidationService,
        passwordValidationService: passwordValidationService,
        ageValidationService: ageValidationService,
        loginService: loginService
      )

      let viewController = RegistrationViewController()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
