import 'package:flutter/material.dart';

class NavigationText extends StatelessWidget {
 const  NavigationText({super.key , required this.accountAsk , required this.verb  , required this.onTap});
final String accountAsk ;
 final  String verb ;
 final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(accountAsk),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: onTap,
            child: Text(verb , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
      ],
    );
  }
}
