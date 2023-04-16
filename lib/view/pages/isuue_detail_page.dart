import 'package:flutter/material.dart';
import 'package:toridori/view/components/issue_comment.dart';
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
      body: Column(
          children: [
            issueDetailWidget(context, issue),
            Flexible(child: ListView.builder(
              itemCount: issue['comments']['nodes'].length,
              itemBuilder: (context, index) {
                final comment = issue['comments']['nodes'][index];
                return IssueComment(context, comment);
            })),
        ],
      ),
    );
  }
}