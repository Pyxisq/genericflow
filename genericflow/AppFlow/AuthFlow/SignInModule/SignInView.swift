import UIKit
import SnapKit

final class SignInView: BaseView {

  let emailTextField = UITextField()
  private let emailErrorLabel = UILabel()
  let passwordTextField = UITextField()
  private let passwordErrorLabel = UILabel()

  let submitButton = UIButton(type: .system)
  let registerButton = UIButton(type: .system)

  override func setupInitialLayout() {
    let buttonsStackView = UIStackView(
      views: [registerButton, submitButton],
      axis: .vertical,
      spacing: 16
    )

    let contentStackView = UIStackView(
      views: [emailTextField, emailErrorLabel, passwordTextField, passwordErrorLabel, buttonsStackView],
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

    emailTextField.placeholder = "Email"
    emailErrorLabel.text = "Incorrect email"
    passwordTextField.placeholder = "Password"
    passwordErrorLabel.text = "Incorrect password"

    submitButton.setTitle("Sign in", for: .normal)
    registerButton.setTitle("Register", for: .normal)
  }

  func set(emailError: Bool) {
    emailErrorLabel.isHidden = !emailError
  }

  func set(passwordError: Bool) {
    passwordErrorLabel.isHidden = !passwordError
  }
}
