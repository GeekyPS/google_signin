import 'package:flutter/material.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        }),
      ),
      routes: {
        AuthScreen.routename: (context) => AuthScreen(),
        ChatScreen.routename: (context) => ChatScreen(),
      },
    );
  }
}
