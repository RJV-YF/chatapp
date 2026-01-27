import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // instance of cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {'uid': doc.id, ...doc.data()};
      }).toList();
    });
  }

  // send messages
  Future<void> sendMessages(String receiverID, String message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timeStamp: timestamp,
    );
    // create a chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // receive messages
  Stream<QuerySnapshot> getMessages(String userID, String receiverID) {
    // create a chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // get messages from database
    return _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }
}
