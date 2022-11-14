import 'package:chat_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> googleSignIn(context) async {
  final googleSignIn = GoogleSignIn();
  final googleAccount = await googleSignIn.signIn();
  if (googleAccount != null) {
    final googleAuth = await googleAccount.authentication;

    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      try {
        await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken));
        final name = googleAccount.displayName;
        final imageUrl = googleAccount.photoUrl;
        final email = googleAccount.email;

        final _storage = FlutterSecureStorage();
        await _storage.write(key: 'user', value: email);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Hi, $name, your email id is $email'),
                content:
                    CircleAvatar(child: Image.network(imageUrl ?? 'hello')),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ChatScreen.routename);
                    },
                    child: const Text('next'),
                  ),
                  TextButton(
                      onPressed: () {
                        logout(context);
                      },
                      child: const Text('Logout'))
                ],
              );
            });
      } on FirebaseException catch (error) {
        print(error.message);
      }
    }
  }
}

Future<void> logout(context) async {
  final googleSignIn = GoogleSignIn();
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamed(AuthScreen.routename);
}
