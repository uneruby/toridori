import 'package:flutter/material.dart';
import 'package:toridori/view/parts/view_fullissue_button.dart';
import 'package:toridori/view/parts/issue_discription.dart';

Widget issueDetailWidget(context, dynamic issue){
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
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child:Text('No.${issue['number']}')
        ),
        Row(children:[
          (issue['closed'])?const Icon(Icons.check_circle, color: Colors.purple,):const Icon(Icons.info, color: Colors.green,), 
          Text(issue['title']),
          ],),
        issueDiscription((issue)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(children:[
            SizedBox(
              width: 30,
              height: 30,
              child:Image.network(issue['author']['avatarUrl']),
            ),
            Text(issue['author']['login']),
          ],),
          Text('${issue['createdAt']}'),
      ],
    ),
  ],),
  );
}