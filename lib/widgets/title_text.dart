import 'package:flutter/material.dart';

class TitleText  extends StatelessWidget {
  const TitleText ({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Global Chat" , style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),);
  }
}
