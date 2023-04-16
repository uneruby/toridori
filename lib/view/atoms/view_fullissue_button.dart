import 'package:flutter/material.dart';
import '../isuue_detail_page.dart';


Widget viewButton(BuildContext context, dynamic issue){
  return ElevatedButton(
    child: Text('View full issue'),
    onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IsuueDetailPage(issue: issue)),
      );
    },
    );
}