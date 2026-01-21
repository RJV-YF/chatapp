import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/widgets/chat_user_tile.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();

    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          final currentUserId = FirebaseAuth.instance.currentUser!.uid;

          final users = (snapshot.data ?? [])
              .where((user) => user['uid'] != currentUserId)
              .toList();

          if (users.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final user = users[index];
              return ChatUserTile(
                name: user['name'],
                email: user['email'],
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
