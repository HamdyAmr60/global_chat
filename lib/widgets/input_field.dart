import 'package:flutter/material.dart';
class InputField extends StatelessWidget {
 const  InputField({super.key , required this.password , required this.hintText , required this.labelText , required this.validator , required this.onSaved});
final bool password;
final String hintText;
final String labelText;
final FormFieldSetter<String> onSaved;
final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      obscureText: password,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white , fontSize: 18),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white , fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white)
        )
      ),


    );
  }
}
