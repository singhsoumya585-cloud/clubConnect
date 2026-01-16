// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'register_screen.dart';
// // import 'password_recovery_screen.dart';
// // import 'home_screen.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _auth = FirebaseAuth.instance;
// //   bool _loading = false;

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   void _login() async {
// //     final email = _emailController.text.trim();
// //     final password = _passwordController.text.trim();

// //     if (email.isEmpty || password.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please enter email and password')),
// //       );
// //       return;
// //     }

// //     setState(() => _loading = true);

// //     try {
// //       await _auth.signInWithEmailAndPassword(email: email, password: password);
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) =>  HomeScreen()),
// //       );
// //     } on FirebaseAuthException catch (e) {
// //       String message = 'Login failed';
// //       if (e.code == 'user-not-found') {
// //         message = 'No user found with this email';
// //       } else if (e.code == 'wrong-password') {
// //         message = 'Incorrect password';
// //       }
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// //     } finally {
// //       setState(() => _loading = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Login')),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 50),
// //               TextField(
// //                 controller: _emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Email',
// //                   border: OutlineInputBorder(),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               TextField(
// //                 controller: _passwordController,
// //                 obscureText: true,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Password',
// //                   border: OutlineInputBorder(),
// //                 ),
// //               ),
// //               const SizedBox(height: 24),
// //               _loading
// //                   ? const CircularProgressIndicator()
// //                   : SizedBox(
// //                       width: double.infinity,
// //                       child: ElevatedButton(
// //                         onPressed: _login,
// //                         child: const Text('Login'),
// //                       ),
// //                     ),
// //               const SizedBox(height: 12),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (_) =>  PasswordRecoveryScreen()),
// //                   );
// //                 },
// //                 child: const Text('Forgot Password?'),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (_) =>  RegisterScreen()),
// //                   );
// //                 },
// //                 child: const Text('Don\'t have an account? Register'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Text(
//           'LOGIN SCREEN LOADED',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Login Screen Loaded',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Icon(Icons.check_circle, color: Colors.green, size: 48),
          ],
        ),
      ),
    );
  }
}
