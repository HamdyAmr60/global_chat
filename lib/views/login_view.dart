import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/services/auth_service.dart';
import 'package:global_chat/views/register_view.dart';
import 'package:global_chat/widgets/title_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../widgets/navigation_text.dart';
import 'chat_view.dart';

class LoginView extends StatefulWidget {
const   LoginView({super.key});
   static  String routeName = "Login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String password = "";
  bool isCalled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ModalProgressHUD(
          inAsyncCall: isCalled,
          child: Form(
            key: formKey,
            child: ListView(

              children: [
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(),
                  ],
                ),
                SizedBox(height: 20,),
                InputField(validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
                  onSaved: (value) {
                    email = value!;
                  },
                  password: false,
                  hintText: "Enter your email",
                  labelText: "Email",),
                SizedBox(height: 20,),
                InputField(validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                  onSaved: (value) {
                    password = value!;
                  },
                  password: true,
                  hintText: "Enter your password",
                  labelText: "Password",),
                SizedBox(height: 20,),
                CustomButton(text: "Login", onTap: () async {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  setState(() => isCalled = true);
                  final navigator = Navigator.of(context);
                  try {
                    await AuthService().signIn(email, password);
                    if (!mounted) return;
                    navigator.pushNamed(ChatView.routeName);
                  } on FirebaseAuthException catch (e) {
                    if (!mounted) return;
                    handleFirebaseError(e, context);
                  } catch (e) {
                    if (!mounted) return;
                    debugPrint(e.toString());
                  } finally {
                    if (mounted) setState(() => isCalled = false);
                  }
                }),
                SizedBox(height: 20,),
                NavigationText(accountAsk: "Don't have an account?",
                  verb: "Sign Up",
                  onTap: () {
                    Navigator.pushNamed(context, RegisterView.routeName);
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void  showSnackBar(String message , BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

void handleFirebaseError(FirebaseAuthException e , BuildContext context) {
  if (e.code == 'user-not-found') {
    showSnackBar("No user found for that email." , context);
  } else if (e.code == 'wrong-password') {
    showSnackBar('Wrong password provided for that user.' , context);
  }
  else {
    showSnackBar(e.message ?? "Authentication error" , context);
  }
}