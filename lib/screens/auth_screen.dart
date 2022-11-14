
import 'package:flutter/material.dart';
import '../models/auth_models.dart';

// ignore: must_be_immutable
class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  static const routename = '/auth';
  var _isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const CircularProgressIndicator()
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  googleSignIn(context);
                },
                child: const Text('google sign in'),
              ),
            ),
    );
  }
}
