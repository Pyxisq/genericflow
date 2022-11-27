import Foundation

protocol AgeValidationService {

  func validate(age: String) -> Bool

}

final class AgeValidationServiceImpl: AgeValidationService {

  func validate(age: String) -> Bool {
    guard let age = Int(age) else {
      return false
    }
    return age >= 18 && age < 100
  }

}
