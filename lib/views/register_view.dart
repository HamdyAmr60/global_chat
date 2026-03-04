import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/services/auth_service.dart';
import 'package:global_chat/widgets/input_field.dart';
import 'package:global_chat/widgets/title_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import '../widgets/navigation_text.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String routeName = "/Register";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [TitleText()],
                ),
                const SizedBox(height: 20),
                InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                  onSaved: (value) => email = value!,
                  password: false,
                  hintText: "Enter your email:",
                  labelText: "Email",
                ),
                const SizedBox(height: 20),
                InputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                  onSaved: (value) => password = value!,
                  password: true,
                  hintText: "Enter your password:",
                  labelText: "Password",
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Register",
                  onTap: () async {
                    if (!formKey.currentState!.validate()) return;

                    formKey.currentState!.save();

                    setState(() => isCalled = true);

                    final navigator = Navigator.of(context);

                    try {
                      await AuthService().signup(email!, password!);

                      if (!mounted) return;
                      navigator.pop(); // Close register screen after success
                    } on FirebaseAuthException catch (e) {
                      if (!mounted) return;
                      handleFirebaseError(e, context);
                    } catch (e) {
                      if (!mounted) return;
                      debugPrint(e.toString());
                    } finally {
                      if (mounted) setState(() => isCalled = false);
                    }
                  },
                ),
                const SizedBox(height: 20),
                NavigationText(
                  accountAsk: "Already have an account?",
                  verb: "Login",
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

void handleFirebaseError(FirebaseAuthException e, BuildContext context) {
  if (e.code == 'weak-password') {
    showSnackBar("The password provided is too weak.", context);
  } else if (e.code == 'email-already-in-use') {
    showSnackBar("Email already in use.", context);
  } else {
    showSnackBar(e.message ?? "Authentication error.", context);
  }
}