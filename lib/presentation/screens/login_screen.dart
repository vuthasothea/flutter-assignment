import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/data/models/login_model.dart';
import 'package:final_project_with_firebase/presentation/blocs/login/login_bloc.dart';
import 'package:final_project_with_firebase/presentation/screens/home_screen.dart';
import 'package:final_project_with_firebase/presentation/screens/signup_screen.dart';
import 'package:final_project_with_firebase/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _invisiblePassword = true;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if(state is LoginInProcessState) {
            EasyLoading.show(status: 'LOADING...', maskType: EasyLoadingMaskType.black);
          } else if(state is LoginFailureState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Login Failed"),
                content: Text(state.message),
                actions: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              ),
            );
          } else if(state is LoginSuccessState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }          
        },
        builder: (context, state) {
          return Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(AppVariable.STANDARD_PADDING),
                  children: [
                    Column(
                      children: [
                        Image(
                          image: AssetImage("assets/login.png"),
                          width: 120,
                        ),
                        SizedBox(height: AppVariable.STANDARD_PADDING / 2),
                        Text("Welcome Back",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        Text("Sign to countinue"),
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  label: Text("Email"),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) => email = value,
                              ),
                              TextFormField(
                                obscureText: _invisiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _invisiblePassword =
                                              !_invisiblePassword;
                                        });
                                      },
                                      icon: Icon(_invisiblePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  label: Text("Password"),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) => password = value,
                              ),
                              SizedBox(height: AppVariable.STANDARD_PADDING),
                              LoginButton(
                                  title: "Login",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      LoginModel loginModel = LoginModel(email: email!, password: password!);
                                      BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(loginModel: loginModel));
                                    }
                                  }),
                              SizedBox(height: AppVariable.STANDARD_PADDING),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have account?"),
                                  TextButton(
                                      child: Text("Register"),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen())))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
