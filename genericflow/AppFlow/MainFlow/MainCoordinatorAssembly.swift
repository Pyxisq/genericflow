import Swinject

struct MainCoordinatorAssembly: Assembly {

  func assemble(container: Container) {
    container.register(MainCoordinator.self) { (_, parentAssembler: Assembler) in
      let assembler = Assembler(
        [
          ImageListRepositoryAssembly(),
          ImageListModuleAssembly(),
          ImageDescriptionModuleAssembly()
        ],
        parent: parentAssembler
      )

      return MainCoordinatorImpl(router: AppNavigationController(), assembler: assembler)
    }
  }
}
