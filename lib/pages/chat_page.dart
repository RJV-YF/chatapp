import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // text editing controller for message input
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send messages

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatService.sendMessages(receiverID, _messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),
          _buildMessageInput(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    final String senderID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(senderID, receiverID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        final messages = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final messageData = messages[index].data() as Map<String, dynamic>;
            final isSentByCurrentUser = messageData['senderID'] == senderID;

            return ListTile(
              title: Align(
                alignment: isSentByCurrentUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSentByCurrentUser ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    messageData['message'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              sendMessage();
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
