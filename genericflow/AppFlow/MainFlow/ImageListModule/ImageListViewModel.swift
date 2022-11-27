import RxSwift

struct Image: Codable {
  let id: Int
  let pageURL: String
  let type: String
  let tags: String
  let previewURL: String
  let previewWidth: Int
  let previewHeight: Int
  let webformatURL: String
  let webformatWidth: Int
  let webformatHeight: Int
  let largeImageURL: String
  let imageWidth: Int
  let imageHeight: Int
  let imageSize: Int
  let views: Int
  let downloads: Int
  let likes: Int
  let comments: Int
  let user_id: Int
  let user: String
  let userImageURL: String
}

struct ImageResponse: Codable {
  let total: Int
  let totalHits: Int
  let hits: [Image]
}

final class ImageListViewModel {

  struct Input {
    let loadList: Observable<Void>
  }

  struct Output {
    let listSequence: ConnectableObservable<LoadingSequence<[Image]>>
    let list: Observable<[Image]>
  }

  private let imageListRepository: ImageListRepository

  init(
    imageListRepository: ImageListRepository
  ) {
    self.imageListRepository = imageListRepository
  }

  func transform(input: Input) -> Output {
    let listSequence = input.loadList
      .flatMapFirst { [unowned self] in
        self.imageListRepository.fetchNextImages().asLoadingSequence()
      }
      .publish()

    let list = listSequence.element
      .scan([], accumulator: +)

    return Output(
      listSequence: listSequence,
      list: list
    )
  }

}
