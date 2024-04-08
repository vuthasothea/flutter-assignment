part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitialState extends SignupState {}

final class SignupInProcessState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailureState extends SignupState {

  final String message;
  SignupFailureState({required this.message});

}