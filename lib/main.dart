import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/views/chat_view.dart';
import 'package:global_chat/views/login_view.dart';
import 'package:global_chat/views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


 await Firebase.initializeApp();
  runApp(const GlobalChat());
}

class GlobalChat extends StatelessWidget {
  const GlobalChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes:{
        "/Login": (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
      ChatView.routeName: (context) => ChatView(),
      },
      initialRoute: '/Login',
      home: LoginView(),
    );
  }
}
