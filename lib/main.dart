import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/authentication/login_screen.dart';
import 'package:web_admin/home_screen/home_screen.dart';

/*Future<void> main() async {
  await Firebase.initializeApp();
  runApp(const MyApp());
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAS-7CHTAiAMxOe2K9k6DhFqASx4VkLNog",
          appId: "1:1017496255751:web:8466e775b8708a448ad9a2",
          messagingSenderId: "1017496255751",
          projectId: "trial-f79fa"));
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
