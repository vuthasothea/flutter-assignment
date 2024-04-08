part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitialState extends AppState {}

final class AppLoadedState extends AppState {

  final AppModel appModel;
  AppLoadedState({required this.appModel});

}
