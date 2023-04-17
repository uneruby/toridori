import 'package:flutter/material.dart';

Widget issueDiscription(dynamic issue){
  return Container(
    width: double.infinity, 
    decoration: BoxDecoration(
      color: Colors.green[100],
    ),
    child: Column(
      children: [
        const Text("## Discription\n"),
        Text(issue['body']),
      ],
    ),
  );
}