part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class GetSettingAppEvent extends AppEvent {}

class ChangeThemeAppEvent extends AppEvent {

  final bool isNightMode;
  ChangeThemeAppEvent({required this.isNightMode});

}
