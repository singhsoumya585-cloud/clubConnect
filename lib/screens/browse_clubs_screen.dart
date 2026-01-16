import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BrowseClubsScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Clubs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getClubsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No clubs available.'));
          }

          final clubs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              final club = clubs[index];
              final clubId = club.id;
              final clubName = club['name'];
              final clubDescription = club['description'];
              final members = List<String>.from(club['members'] ?? []);

              final userId = _auth.currentUser!.uid;
              final isMember = members.contains(userId);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(clubName),
                  subtitle: Text(clubDescription),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      if (isMember) {
                        await _firestoreService.leaveClub(clubId, userId);
                      } else {
                        await _firestoreService.joinClub(clubId, userId);
                      }
                    },
                    child: Text(isMember ? 'Leave' : 'Join'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
