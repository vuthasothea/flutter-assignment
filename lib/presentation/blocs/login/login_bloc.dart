import 'package:bloc/bloc.dart';
import 'package:final_project_with_firebase/core/exceptions/login_exception.dart';
import 'package:final_project_with_firebase/data/models/login_model.dart';
import 'package:final_project_with_firebase/data/repositories/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {

    on<DoLoginEvent>((event, emit) async {
      try {
        emit(LoginInProcessState());

        LoginRepository repository = LoginRepository();
        await repository.doLogin(event.loginModel);
        
        emit(LoginSuccessState());
      } on LoginException catch (e) {
        emit(LoginFailureState(message: e.message));
      } on Exception catch(_) {
        emit(LoginFailureState(message: "An unknown exception occurred."));
      }
    });

  }
}
