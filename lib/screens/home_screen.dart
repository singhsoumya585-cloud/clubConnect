import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  // Example placeholder club data
  final List<Map<String, String>> _clubs = [
    {'name': 'Art Club', 'description': 'Explore your creativity!'},
    {'name': 'Chess Club', 'description': 'Sharpen your mind!'},
    {'name': 'Science Club', 'description': 'Experiment and learn!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Connect Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _clubs.length,
          itemBuilder: (context, index) {
            final club = _clubs[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(club['name']!),
                subtitle: Text(club['description']!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: Navigate to club details page
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked ${club['name']}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
