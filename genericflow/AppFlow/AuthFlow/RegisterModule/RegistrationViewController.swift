import RxSwift
import RxCocoa

final class RegistrationViewController: BaseViewController<RegistrationView>, RegistrationModule {

  var onRegistered: Completion = {}

  var viewModel: RegistrationViewModel!

  override func setupView() {
    title = "Registration"
  }
  
  override func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        email: rootView.emailTextField.rx.text.unwrap(),
        password: rootView.passwordTextField.rx.text.unwrap(),
        age: rootView.ageTextField.rx.text.unwrap(),
        submit: rootView.registerButton.rx.tap.asObservable()
      )
    )

    output.emailError
      .bind { [unowned self] error in
        self.rootView.set(emailError: error)
      }
      .disposed(by: disposeBag)

    output.passwordError
      .bind { [unowned self] error in
        self.rootView.set(passwordError: error)
      }
      .disposed(by: disposeBag)

    output.ageError
      .bind { [unowned self] error in
        self.rootView.set(ageError: error)
      }
      .disposed(by: disposeBag)

    let registered = output.registered.share()

    registered.loading
      .bind { [unowned self] isLoading in
        // show loading progress
        self.rootView.isUserInteractionEnabled = !isLoading
      }
      .disposed(by: disposeBag)

    registered.element
      .bind { [unowned self] in
        self.onRegistered()
      }
      .disposed(by: disposeBag)


    registered.errors
      .bind {
        print($0)
      }
      .disposed(by: disposeBag)
  }
}
