import 'dart:io';

import 'package:final_project_with_firebase/core/themes/app_theme.dart';
import 'package:final_project_with_firebase/presentation/blocs/app/app_bloc.dart';
import 'package:final_project_with_firebase/presentation/screens/home_screen.dart';
import 'package:final_project_with_firebase/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAdIqfub4WsivCXI-JAXyj2qpdcXT-tbdU',
    appId: '1:1071091674528:android:2ce5c90adea991ee32c8c5',
    messagingSenderId: '',
    projectId: 'flutter-final-project-bd9b8',
    storageBucket: 'com.example.final_project_with_firebase',
  ));
  HttpOverrides.global = AcceptSSLCertificate(); // Accept SSL Certificate

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(GetSettingAppEvent()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Final Project',
            debugShowCheckedModeBanner: false,
            theme: state is AppLoadedState && state.appModel.isNightMode ? AppTheme.dark() : AppTheme.light(),
            home: FirebaseAuth.instance.currentUser != null
                ? HomeScreen()
                : LoginScreen(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}

// Accept SSL Certificate
//------------------------------------------------
class AcceptSSLCertificate extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }  

}