import Swinject

struct ImageListModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(ImageListModule.self) { resolver in
      let imageListRepository = resolver.resolve(ImageListRepository.self)!
      let viewModel = ImageListViewModel(imageListRepository: imageListRepository)
      let viewController = ImageListViewContoller()
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
