import RxSwift
import Foundation

final class ImageListRepositoryImpl: ImageListRepository {

  private let session = URLSession.shared
  private let decoder = JSONDecoder()

  var totalPages = Int.max
  var currentPage = 1

  func fetchNextImages() -> Observable<[Image]> {
    if currentPage >= totalPages {
      return .empty()
    }
    var url = URL(string: "https://pixabay.com/api")!
    url.append(
      queryItems: [
        URLQueryItem(name: "key", value: "31618470-7184be2f7735bf29fb5be12a6"),
        URLQueryItem(name: "image_type", value:  "photo"),
        URLQueryItem(name: "page", value:  currentPage.description)
      ]
    )
    let request = URLRequest(url: url)

    return session.rx
      .data(request: request)
      .map { [unowned self] in
        let response = try self.decoder.decode(ImageResponse.self, from: $0)
        self.totalPages = response.total
        self.currentPage += 1
        return response.hits
      }
  }

}
