import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Users'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? const Center(child: Text('Start typing to search users'))
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No users found'));
                      }

                      final currentUserId = _auth.currentUser?.uid;

                      final filteredDocs = snapshot.data!.docs.where((doc) {
                        if (doc.id == currentUserId) return false;

                        final data = doc.data() as Map<String, dynamic>;
                        final name = (data['name'] ?? '')
                            .toString()
                            .toLowerCase();
                        final email = (data['email'] ?? '')
                            .toString()
                            .toLowerCase();

                        return name.contains(_searchQuery) ||
                            email.contains(_searchQuery);
                      }).toList();

                      if (filteredDocs.isEmpty) {
                        return const Center(child: Text('No users found'));
                      }

                      return ListView.separated(
                        itemCount: filteredDocs.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final userData =
                              filteredDocs[index].data()
                                  as Map<String, dynamic>;

                          final name = userData['name'] ?? 'Unknown';
                          final email = userData['email'] ?? '';

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                              ),
                            ),
                            title: Text(name),
                            subtitle: Text(email),
                            onTap: () {
                              // TODO: Navigate to user profile / start chat
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
