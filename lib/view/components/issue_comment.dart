import 'package:flutter/material.dart';
import 'package:toridori/view/parts/issue_discription.dart';

Widget IssueComment(context, dynamic comment){
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(children:[
            SizedBox(
              width: 30,
              height: 30,
              child:Image.network(comment['author']['avatarUrl']),
            ),
            Text(comment['author']['login']),
          ],),
          Text('${comment['createdAt']}'),
        ],),
        Text('${comment['body']}'),
      ],
    )
  );
}