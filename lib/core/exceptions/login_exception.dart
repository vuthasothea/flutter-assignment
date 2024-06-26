class LoginException implements Exception {

  final String message;
  const LoginException([this.message = "An unknown exception occurred."]);

  factory LoginException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginException('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LoginException('This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const LoginException('Email is not found, please create an account.');
      case 'wrong-password':
        return const LoginException('Incorrect password, please try again.');
      case 'invalid-credential':
        return const LoginException('Invalid email or password.');
      default:
        return const LoginException();
    }
  }  

}