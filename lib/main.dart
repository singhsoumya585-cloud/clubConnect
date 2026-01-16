import 'package:flutter/material.dart';
import 'package:club_connect_new/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ClubConnectApp());
}

class ClubConnectApp extends StatelessWidget{
  const ClubConnectApp({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
       debugShowCheckedModeBanner: false,
    theme:ThemeData( 
    primarySwatch:Colors.orange,
    ),
    home: const WidgetTree(),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const ClubConnectApp());
// }

// class ClubConnectApp extends StatelessWidget {
//   const ClubConnectApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.red,
//         body: Center(
//           child: Text(
//             'IF YOU SEE RED, FLUTTER IS FINE',
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//         ),
//       ),
//     );
//   }
// }
