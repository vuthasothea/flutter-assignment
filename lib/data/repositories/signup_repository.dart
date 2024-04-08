import 'package:final_project_with_firebase/core/exceptions/signup_exception.dart';
import 'package:final_project_with_firebase/data/models/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupRepository {

  Future<void> createNewAccount(SignupModel model) async {
    try {

      // Mark: Create user in FirebaseAuth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: model.email, password: model.password);
      var user = credential.user;
      user?.updateDisplayName(model.username);      

    } on FirebaseAuthException catch(e) {
      throw SignupExecption.fromCode(e.code);
    } catch(_) {
      throw SignupExecption();
    }
  }

}