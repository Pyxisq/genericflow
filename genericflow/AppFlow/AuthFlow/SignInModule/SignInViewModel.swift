import RxSwift

final class SignInViewModel {

  struct Input {
    let email: Observable<String>
    let password: Observable<String>
    let submit: Observable<Void>
  }

  struct Output {
    let emailError: Observable<Bool>
    let passwordError: Observable<Bool>
    let signedIn: Observable<LoadingSequence<Void>>
  }

  private let emailValidationService: EmailValidationService
  private let passwordValidationService: PasswordValidationService
  private let loginService: LoginService

  init(
    emailValidationService: EmailValidationService,
    passwordValidationService: PasswordValidationService,
    loginService: LoginService
  ) {
    self.emailValidationService = emailValidationService
    self.passwordValidationService = passwordValidationService
    self.loginService = loginService
  }


  func transform(input: Input) -> Output {
    let emailError = input.submit
      .withLatestFrom(input.email)
      .map { [unowned self] email in
        !self.emailValidationService.validate(email: email)
      }

    let passwordError = input.submit
      .withLatestFrom(input.password)
      .map { [unowned self] password in
        !self.passwordValidationService.validate(password: password)
      }

    let signedIn = Observable.combineLatest(emailError, passwordError)
      .flatMap { emailError, passwordError -> Observable<Void> in
        if !emailError && !passwordError {
          return .just(())
        }
        return .empty()
      }
      .withLatestFrom(Observable.combineLatest(input.email, input.password))
      .flatMap { [loginService] email, password in
        loginService.login(email: email, password: password)
          .asLoadingSequence()
      }

    return Output(
      emailError: emailError,
      passwordError: passwordError,
      signedIn: signedIn
    )
  }

}
