import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist_flutter/screen/auth/login_screen.dart';
import 'package:todolist_flutter/screen/auth/register_screen.dart';
import 'package:todolist_flutter/screen/todo/create_screen.dart';
import 'package:todolist_flutter/screen/todo/edit_screen.dart';
import 'package:todolist_flutter/screen/todo/index_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
      'Notification Received (foreground): ${message.notification?.title}',
    );
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Notifikasi diterima di background: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? '/login'
          : '/todo',
      routes: {
        '/login': (context) => const LoginScreen(title: 'Login'),
        '/register': (context) => const RegisterScreen(title: 'Register'),
        '/todo': (context) => const IndexScreen(title: 'To Do List'),
        '/todo/create': (context) => const CreateScreen(title: 'Create'),
        '/todo/edit': (context) => const EditScreen(title: 'Edit'),
      },
    );
  }
}
