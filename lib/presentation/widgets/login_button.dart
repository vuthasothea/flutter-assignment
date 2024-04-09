import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  
  final VoidCallback onPressed;
  final String title;
  LoginButton({ required this.title, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
        ),        
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

}