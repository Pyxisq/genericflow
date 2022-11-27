import RxSwift
import RxCocoa

final class SignInViewController: BaseViewController<SignInView>, SignInModule {

  var onRegisterTap: Completion = {}
  var onSignedIn: Completion = {}

  var viewModel: SignInViewModel!

  override func setupView() {
    title = "Sign in"
  }

  override func bindView() {
    rootView.registerButton.rx.tap
      .bind { [unowned self] in
        self.onRegisterTap()
      }
      .disposed(by: disposeBag)
  }

  override func bindViewModel() {
    let output = viewModel.transform(
      input: .init(
        email: rootView.emailTextField.rx.text.unwrap(),
        password: rootView.passwordTextField.rx.text.unwrap(),
        submit: rootView.submitButton.rx.tap.asObservable()
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

    let signedIn = output.signedIn.share()

    signedIn.loading
      .bind { [unowned self] isLoading in
        // show loading progress
        self.rootView.isUserInteractionEnabled = !isLoading
      }
      .disposed(by: disposeBag)
    
    signedIn.element
      .bind { [unowned self] in
        self.onSignedIn()
      }
      .disposed(by: disposeBag)


    signedIn.errors
      .bind {
        print($0)
      }
      .disposed(by: disposeBag)
  }
}
