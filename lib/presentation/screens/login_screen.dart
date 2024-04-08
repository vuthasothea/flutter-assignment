import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/presentation/screens/signup_screen.dart';
import 'package:final_project_with_firebase/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {    

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
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    )
                  ),
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
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            label: Text("Password"),
                          ),
                        ),
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                        LoginButton(
                          title: "Login",
                          onPressed: () {
                          
                          }
                        ),
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have account?"),
                            TextButton(
                              child: Text("Register"),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()))
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
  }

}