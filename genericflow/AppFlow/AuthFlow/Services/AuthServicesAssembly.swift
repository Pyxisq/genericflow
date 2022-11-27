import Swinject

struct AuthServicesAssembly: Assembly {

  func assemble(container: Container) {
    container.register(EmailValidationService.self) { _ in
      EmailValidationServiceImpl()
    }
    container.register(PasswordValidationService.self) { _ in
      PasswordValidationServiceImpl()
    }
    container.register(AgeValidationService.self) { _ in
        AgeValidationServiceImpl()
    }
    container.register(LoginService.self) { _ in
      LoginServiceImpl()
    }
  }

}
