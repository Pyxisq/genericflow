protocol SignInModule: Presentable {

  var onRegisterTap: Completion { get set }
  var onSignedIn: Completion { get set }

}
