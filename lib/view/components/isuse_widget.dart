import 'package:flutter/material.dart';
import 'package:toridori/view/parts/view_fullissue_button.dart';
import 'package:toridori/view/parts/issue_discription.dart';

Widget issueWidget(context, dynamic issue){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, //色
                    spreadRadius: 1, 
                    blurRadius: 3, 
                    offset: Offset(1, 1),
                  ),
                ],
    //   border: Border.all(color: const Color.fromARGB(255, 98, 98, 98)),
    borderRadius: BorderRadius.circular(5),
    ),
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(8),
    child: Column(
      children: [
        Text('No.${issue['number']}'),
        Row(children:[
          const Icon(Icons.info, color: Colors.green,), 
          Text(issue['title']),
          ],),
        issueDiscription((issue)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                const Icon(Icons.person),
                Text(issue['author']['login']),
                ],),
                Text(issue['createdAt']),
              ],
            ),
            viewButton(context, issue),
          ],)
      ],
    ),
  );
}