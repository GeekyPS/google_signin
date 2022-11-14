import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = "";
  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send a message..'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                     final googleSignIn = GoogleSignIn();
                      final googleAccount = await googleSignIn.signIn();
                      FirebaseFirestore.instance.collection('chat').add(
                        {
                          'text': _enteredMessage,
                          'createdAt': Timestamp.now(),
                          'userID':googleAccount?.email,
                        },
                      );
                      _controller.clear();
                    },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
