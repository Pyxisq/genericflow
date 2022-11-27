import UIKit

final class RegistrationView: BaseView {

  let emailTextField = UITextField()
  private let emailErrorLabel = UILabel()
  let passwordTextField = UITextField()
  private let passwordErrorLabel = UILabel()
  let ageTextField = UITextField()
  private let ageErrorLabel = UILabel()

  let registerButton = UIButton(type: .system)

  override func setupInitialLayout() {

    let contentStackView = UIStackView(
      views: [emailTextField,
              emailErrorLabel,
              passwordTextField,
              passwordErrorLabel,
              ageTextField,
              ageErrorLabel,
              registerButton],
      axis: .vertical,
      spacing: 16
    )
    addSubview(contentStackView)
    contentStackView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
    }
  }

  override func configureViews() {
    backgroundColor = .white

    emailErrorLabel.isHidden = true
    passwordErrorLabel.isHidden = true
    ageErrorLabel.isHidden = true

    ageTextField.keyboardType = .numberPad

    emailTextField.placeholder = "Email"
    emailErrorLabel.text = "Incorrect email"
    passwordTextField.placeholder = "Password"
    passwordErrorLabel.text = "Incorrect password"
    ageTextField.placeholder = "Age"
    ageErrorLabel.text = "Incorrect age >18 <99"

    registerButton.setTitle("Register", for: .normal)
  }

  func set(emailError: Bool) {
    emailErrorLabel.isHidden = !emailError
  }

  func set(passwordError: Bool) {
    passwordErrorLabel.isHidden = !passwordError
  }

  func set(ageError: Bool) {
    ageErrorLabel.isHidden = !ageError
  }

}
