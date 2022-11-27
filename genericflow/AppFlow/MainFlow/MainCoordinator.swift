protocol MainCoordinator: Coordinator {}

final class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

  override func start() {
    showImageList()
  }

  private func showImageList() {
    var module = assembler.resolver.resolve(ImageListModule.self)
    module?.onImageTap = { [weak self] image in
      self?.showImageDescription(image: image)
    }
    router.push(module)
  }

  private func showImageDescription(image: Image) {
    let module = assembler.resolver.resolve(ImageDescriptionModule.self, argument: image)
    router.push(module)
  }
}
