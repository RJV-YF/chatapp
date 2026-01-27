import 'package:chatapp/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SafeArea(
        child: user == null
            ? const Center(child: Text('No user logged in'))
            : StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text('User profile not found'));
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final name = data['name'] ?? 'Unknown';
                  final email = data['email'] ?? user.email ?? '';

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 44,
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : '?',
                              style: const TextStyle(fontSize: 34),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.person_outline),
                          title: const Text('Name'),
                          subtitle: Text(name),
                        ),

                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.email_outlined),
                          title: const Text('Email'),
                          subtitle: Text(email),
                        ),

                        const Spacer(),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: _signOut,
                            icon: const Icon(Icons.logout),
                            label: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
