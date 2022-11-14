import 'package:chat_app/chat/new_messages.dart';

import '../chat/messages.dart';
import 'package:chat_app/models/auth_models.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routename = '/chat';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              logout(context);
            },
            child: const Text(
              'logout',
              style: TextStyle(color: Colors.black),
            ))
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            const NewMessage(),
          ],
        ),
      ),
    );
  }
}
