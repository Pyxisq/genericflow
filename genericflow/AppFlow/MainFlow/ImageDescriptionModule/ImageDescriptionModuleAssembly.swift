import Swinject

struct ImageDescriptionModuleAssembly: Assembly {

  func assemble(container: Container) {
    container.register(ImageDescriptionModule.self) { (_, image: Image) in
      ImageDescriptionViewController(image: image)
    }
  }
}
