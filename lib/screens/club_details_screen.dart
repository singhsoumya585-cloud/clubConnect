import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubDetailsScreen extends StatefulWidget {
  final String clubId;

  const ClubDetailsScreen({required this.clubId, super.key});

  @override
  _ClubDetailsScreenState createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final _auth = FirebaseAuth.instance;

  final _eventTitleController = TextEditingController();
  final _announcementTitleController = TextEditingController();
  final _announcementBodyController = TextEditingController();

  bool _loadingEvent = false;
  bool _loadingAnnouncement = false;

  Future<bool> isLeader(String clubId, String userId) async {
    final clubDoc = await FirebaseFirestore.instance.collection('clubs').doc(clubId).get();
    final data = clubDoc.data();
    if (data != null && data['leaders'] != null) {
      return (data['leaders'] as List).contains(userId);
    }
    return false;
  }

  void _addEvent() async {
    setState(() => _loadingEvent = true);

    final eventData = {
      'title': _eventTitleController.text.trim(),
      'date': Timestamp.now(),
    };

    await _firestoreService.addEvent(widget.clubId, eventData);

    _eventTitleController.clear();
    setState(() => _loadingEvent = false);
  }

  void _addAnnouncement() async {
    setState(() => _loadingAnnouncement = true);

    final announcementData = {
      'title': _announcementTitleController.text.trim(),
      'body': _announcementBodyController.text.trim(),
      'date': Timestamp.now(),
    };

    await _firestoreService.addAnnouncement(widget.clubId, announcementData);

    _announcementTitleController.clear();
    _announcementBodyController.clear();
    setState(() => _loadingAnnouncement = false);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Club Details')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestoreService.getClubStream(widget.clubId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final clubData = snapshot.data!.data() as Map<String, dynamic>;
          final events = List.from(clubData['events'] ?? []);
          final announcements = List.from(clubData['announcements'] ?? []);

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(clubData['name'] ?? 'Club', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),

                // EVENTS SECTION
                Text('Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ...events.map((e) => ListTile(title: Text(e['title'] ?? ''))),

                SizedBox(height: 20),
                FutureBuilder<bool>(
                  future: isLeader(widget.clubId, currentUser!.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || !snapshot.data!) return SizedBox.shrink(); // Not a leader, no inputs
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _eventTitleController,
                          decoration: InputDecoration(labelText: 'New Event Title'),
                        ),
                        SizedBox(height: 8),
                        _loadingEvent
                            ? CircularProgressIndicator()
                            : ElevatedButton(onPressed: _addEvent, child: Text('Add Event')),
                      ],
                    );
                  },
                ),

                Divider(height: 40),

                // ANNOUNCEMENTS SECTION
                Text('Announcements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ...announcements.map((a) => ListTile(
                      title: Text(a['title'] ?? ''),
                      subtitle: Text(a['body'] ?? ''),
                    )),

                SizedBox(height: 20),
                FutureBuilder<bool>(
                  future: isLeader(widget.clubId, currentUser.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || !snapshot.data!) return SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _announcementTitleController,
                          decoration: InputDecoration(labelText: 'Announcement Title'),
                        ),
                        TextField(
                          controller: _announcementBodyController,
                          decoration: InputDecoration(labelText: 'Announcement Body'),
                        ),
                        SizedBox(height: 8),
                        _loadingAnnouncement
                            ? CircularProgressIndicator()
                            : ElevatedButton(onPressed: _addAnnouncement, child: Text('Add Announcement')),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
