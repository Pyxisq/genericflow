import Foundation

protocol PasswordValidationService {

  func validate(password: String) -> Bool

}

final class PasswordValidationServiceImpl: PasswordValidationService {

  func validate(password: String) -> Bool {
    password.count >= 6 && password.count <= 12
  }

}
