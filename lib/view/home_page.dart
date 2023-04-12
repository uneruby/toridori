import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/model/constants.dart';
import 'package:toridori/notifier/label_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/model/api_query.dart';

class MyHomePage extends HookConsumerWidget {
  String readRepositories = Constants.readRepositories;

  QueryResult? queryResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _labelState = ref.watch(labelProvider);
    final _labelStateNotifier = ref.read(labelProvider.notifier);
    // print(_labelState);

    if(queryResult == null) {
      queryResult = Querymethod().query();
      print("呼び出し");
    }

    final allIssues = queryResult?.data?['repository']['issues']['nodes'] ?? [];
    print(allIssues);


    final issues = allIssues.where((issue) {
      final labels = issue['labels']['nodes'] as List<dynamic>;
      if(_labelState.name == null){
        return true;
      }
      return labels.any((label) => label['name'] == _labelState.name);
    }).toList();

    print(issues);

        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Issues'),
            actions: <Widget>[
              ElevatedButton(onPressed: () {Future(() {
                    _labelStateNotifier.setLabel("bug");
                  });}, 
                  child: const Text("bug")),
              ElevatedButton(onPressed: () {Future(() {
                    _labelStateNotifier.setLabel("documentation");
                  });}, 
                  child: const Text("documentation")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel("duplicate");
              });}, 
              child: const Text("duplicate")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel(null);
              });}, 
              child: const Text("全て")),
            ],
          ),
          body: ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              //print(issue);
              final labels = issue['labels']['nodes'];
              // labelがついていない時空文字列を返す
              final labelName = labels.isNotEmpty ? labels[0]['name'] : '';

              return ListTile(
                title: Text(issue['title']),
                subtitle: Text('by ${issue['author']['login']} label: $labelName'),
                trailing: Text(issue['createdAt']),
                onTap: () {
                  // ウィジェットツリーの構築までプロバイダーの値の変更を遅延
                  Future(() {
                    _labelStateNotifier.setLabel("bug");
                  });
                },
              );
            },
          ),
        );
      }
}