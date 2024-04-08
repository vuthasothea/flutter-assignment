part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class GetSettingAppEvent extends AppEvent {}

class ChangeSettingAppEvent extends AppEvent {}
