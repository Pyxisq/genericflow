import RxSwift

protocol ImageListRepository {

  func fetchNextImages() -> Observable<[Image]>

}
