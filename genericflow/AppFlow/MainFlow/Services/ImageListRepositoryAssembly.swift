import Swinject

struct ImageListRepositoryAssembly: Assembly {

  func assemble(container: Container) {
    container.register(ImageListRepository.self) { _ in
      ImageListRepositoryImpl()
    }
  }
}
