class SignupExecption implements Exception {

  final String message;
  const SignupExecption([this.message = "An unknown exception occurred."]);

  factory SignupExecption.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignupExecption('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const SignupExecption('This user has been disabled. Please contact support for help.');
      case 'email-already-in-use':
        return const SignupExecption('An account already exists for that email.');
      case 'operation-not-allowed':
        return const SignupExecption('Operation is not allowed.  Please contact support.');
      case 'weak-password':
        return const SignupExecption('Please enter a stronger password.');
      default:
        return const SignupExecption();
    }
  }  

}