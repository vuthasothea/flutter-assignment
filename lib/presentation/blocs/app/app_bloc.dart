import 'package:bloc/bloc.dart';
import 'package:final_project_with_firebase/data/models/app_model.dart';
import 'package:final_project_with_firebase/data/repositories/app_repository.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitialState()) {

    on<GetSettingAppEvent>((event, emit) async {
      AppRepository repository = AppRepository();
      AppModel appModel = await repository.getAppSetting();
      emit(AppLoadedState(appModel: appModel));
    });

    on<ChangeThemeAppEvent>((event, emit) async {
      var currentState = state;
      if(currentState is AppLoadedState) {
        var appModel = currentState.appModel;
        appModel.isNightMode = event.isNightMode;

        AppRepository repository = AppRepository();
        await repository.setAppSetting(appModel);

        emit(AppLoadedState(appModel: appModel));
      }
    });

  }
}
