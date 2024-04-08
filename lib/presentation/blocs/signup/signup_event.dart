part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class DoSignupEvent extends SignupEvent {

  final SignupModel signupModel;

  DoSignupEvent({required this.signupModel});

}