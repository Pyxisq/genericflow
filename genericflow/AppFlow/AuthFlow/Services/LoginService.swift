import RxSwift

protocol LoginService {

  func login(email: String, password: String) -> Observable<Void>
  func register(email: String, password: String, age: String) -> Observable<Void>

}

final class LoginServiceImpl: LoginService {

  func login(email: String, password: String) -> Observable<Void> {
    Observable.deferred {
      .just(())
      .delay(.seconds(2), scheduler: MainScheduler.instance)
    }
  }

  func register(email: String, password: String, age: String) -> Observable<Void> {
    Observable.deferred {
      .just(())
      .delay(.seconds(1), scheduler: MainScheduler.instance)
    }
  }

}
