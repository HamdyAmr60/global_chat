import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key , required this.text , required this.onTap});
final String text;
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
          borderRadius: BorderRadius.circular(8)
        ),
        height: 50,
        width: double.infinity,
        child: Center(child: Text(text  , style: TextStyle(color: Colors.white , fontSize: 20,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
