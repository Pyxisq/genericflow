import RxSwift

final class RegistrationViewModel {

  struct Input {
    let email: Observable<String>
    let password: Observable<String>
    let age: Observable<String>
    let submit: Observable<Void>
  }

  struct Output {
    let emailError: Observable<Bool>
    let passwordError: Observable<Bool>
    let ageError: Observable<Bool>
    let registered: Observable<LoadingSequence<Void>>
  }

  private let emailValidationService: EmailValidationService
  private let passwordValidationService: PasswordValidationService
  private let ageValidationService: AgeValidationService
  private let loginService: LoginService

  init(
    emailValidationService: EmailValidationService,
    passwordValidationService: PasswordValidationService,
    ageValidationService: AgeValidationService,
    loginService: LoginService
  ) {
    self.emailValidationService = emailValidationService
    self.passwordValidationService = passwordValidationService
    self.ageValidationService = ageValidationService
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

    let ageError = input.submit
      .withLatestFrom(input.age)
      .map { [unowned self] age in
        !self.ageValidationService.validate(age: age)
      }

    let registered = Observable.combineLatest(emailError, passwordError, ageError)
      .flatMap { emailError, passwordError, ageError -> Observable<Void> in
        if !emailError && !passwordError && !ageError {
          return .just(())
        }
        return .empty()
      }
      .withLatestFrom(Observable.combineLatest(input.email, input.password, input.age))
      .flatMap { [loginService] email, password, age in
        loginService.register(email: email, password: password, age: age)
          .asLoadingSequence()
      }

    return Output(
      emailError: emailError,
      passwordError: passwordError,
      ageError: ageError,
      registered: registered
    )
  }

}
