import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // instance of cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {'uid': doc.id, ...doc.data()};
      }).toList();
    });
  }

  // send messages

  // receive messages
}
