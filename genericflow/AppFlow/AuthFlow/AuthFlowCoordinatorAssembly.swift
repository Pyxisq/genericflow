import Swinject

struct AuthFlowCoordinatorAssembly: Assembly {

  func assemble(container: Container) {
    container.register(AuthFlowCoordinator.self) { (_, parentAssembler: Assembler) in
      let assembler = Assembler(
        [
          AuthServicesAssembly(),
          SignInModuleAssembly(),
          RegistrationModuleAssembly()
        ],
        parent: parentAssembler
      )

      return AuthFlowCoordinatorImpl(router: AppNavigationController(), assembler: assembler)
    }
  }
}
