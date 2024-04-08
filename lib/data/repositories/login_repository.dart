import 'package:final_project_with_firebase/core/exceptions/login_exception.dart';
import 'package:final_project_with_firebase/data/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {

  Future<void> doLogin(LoginModel loginModel) async {
    try {

      // Mark: Login with FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginModel.email, password: loginModel.password);

    } on FirebaseAuthException catch(e) {
      throw LoginException.fromCode(e.code);
    } catch(_) {
      throw LoginException();
    }
  }

}