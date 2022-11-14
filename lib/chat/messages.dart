import 'package:chat_app/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Messages extends StatelessWidget {
  var _userEmail = "";

  Future<void> cred() async {
    final _storage = FlutterSecureStorage();
    _userEmail = await _storage.read(key: 'user') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('/chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;

        return FutureBuilder(
          future: cred(),
          builder: (context, snapshot) => ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => MessageBubble(
                  message: chatDocs[index]['text'],
                  isMe: chatDocs[index]['userID'] == _userEmail)),
        );
      }),
    );
  }
}
