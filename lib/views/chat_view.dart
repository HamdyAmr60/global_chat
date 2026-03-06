import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatView extends StatelessWidget {
    ChatView({super.key});
  final CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  static String routeName = "Chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Global Chat" , style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                BubbleSpecialThree(
                text: 'Added iMessage shape bubbles',
                color: Color(0xFF1B97F3),
                tail: false,
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),


                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    hintText: "Type a message",
                    suffixIcon: Icon(Icons.send),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white)
                    )


                ),
                onSubmitted: (value) {
 messages.add({
  "message":value
});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
