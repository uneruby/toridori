import 'package:flutter/material.dart';

Widget issueWidget(dynamic issue){
  return Container(
    child: Column(
      children: [
        Text(issue['title']),
        Text(issue['url']),
      ],
    ),
  );
}