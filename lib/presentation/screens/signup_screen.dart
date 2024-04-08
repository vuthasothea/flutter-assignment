import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/core/constants/string_util.dart';
import 'package:final_project_with_firebase/data/models/signup_model.dart';
import 'package:final_project_with_firebase/presentation/blocs/signup/signup_bloc.dart';
import 'package:final_project_with_firebase/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  bool _invisiblePassword = true;
  String? username;
  String? email;
  String? password;  

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SignupBloc(),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if(state is SignupInProcessState) {
            EasyLoading.show(status: 'LOADING...', maskType: EasyLoadingMaskType.black);
          } else if(state is SignupFailureState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Signup Failed"),
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
          } else if(state is SignupSuccessState) {
            EasyLoading.showSuccess("Signup Successfully");
            Navigator.pop(context);
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
                          image: AssetImage("assets/register.png"),
                          width: 120,
                        ),
                        SizedBox(height: AppVariable.STANDARD_PADDING / 2),
                        Text(
                          "Register New Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                          )
                        ),
                        Text("Sign up countinue"),
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline),
                                  label: Text("Username"),
                                ),
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return "Username is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) => username = value,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  label: Text("Email"),
                                ),
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return "Email is required";
                                  } else if(!StringUtil.validateEmail(value)) {
                                    return "A valid email is required";
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
                                        _invisiblePassword = !_invisiblePassword;
                                      });
                                    },
                                    icon: Icon(_invisiblePassword ? Icons.visibility : Icons.visibility_off)
                                  ),
                                  label: Text("Password"),
                                ),
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return "Password is required";
                                  } else if(!StringUtil.validateComplexPassword(value)) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                onChanged: (value) => password = value,
                              ),
                              SizedBox(height: AppVariable.STANDARD_PADDING),
                              LoginButton(
                                title: "Sign up",
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                    SignupModel signupModel = SignupModel(username: username!, email: email!, password: password!);
                                    BlocProvider.of<SignupBloc>(context).add(DoSignupEvent(signupModel: signupModel));
                                  }
                                }
                              ),
                              SizedBox(height: AppVariable.STANDARD_PADDING),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have account?"),
                                  TextButton(
                                    child: Text("Login"),
                                    onPressed: () => Navigator.pop(context)
                                  )
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