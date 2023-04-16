import 'package:flutter/material.dart';

import '../components/isuse_widget.dart';

class IsuueDetailPage extends StatelessWidget {
  IsuueDetailPage({super.key, required this.issue});
  dynamic issue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Detail'),
      ),
      body: issueWidget(context, issue),
    );
  }
}