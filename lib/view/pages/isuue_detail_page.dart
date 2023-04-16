import 'package:flutter/material.dart';
import '../components/issue_detail_widget.dart';


class IsuueDetailPage extends StatelessWidget {
  IsuueDetailPage({super.key, required this.issue});
  dynamic issue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Detail'),
      ),
      body: issueDetailWidget(context, issue),
    );
  }
}