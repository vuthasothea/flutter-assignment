import 'package:bloc/bloc.dart';
import 'package:final_project_with_firebase/core/exceptions/signup_exception.dart';
import 'package:final_project_with_firebase/data/models/signup_model.dart';
import 'package:final_project_with_firebase/data/repositories/signup_repository.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    
    on<DoSignupEvent>((event, emit) async {      
      try {
        emit(SignupInProcessState());

        SignupRepository repository = SignupRepository();
        await repository.createNewAccount(event.signupModel);
        
        emit(SignupSuccessState());
      } on SignupExecption catch (e) {
        emit(SignupFailureState(message: e.message));
      } on Exception catch(_) {
        emit(SignupFailureState(message: "An unknown exception occurred."));
      }
    });

  }
}
