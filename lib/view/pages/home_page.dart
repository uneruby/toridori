import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/model/constants.dart';
import 'package:toridori/notifier/label_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/model/api_query.dart';
import 'package:toridori/view/components/isuse_widget.dart';

class MyHomePage extends HookConsumerWidget {
  String readRepositories = Constants.readRepositories;

  QueryResult? queryResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _labelState = ref.watch(labelProvider);
    final _labelStateNotifier = ref.read(labelProvider.notifier);
    // print(_labelState);

    // final Querymethod querymethod = Querymethod();

    final config = ref.watch(
      useMemoized(() => FutureProvider.autoDispose<QueryResult>((ref) async {
        final queryResult = await Querymethod().query();
        // print("queryResult");
        print(queryResult);
        return queryResult;
      })),
    );

    print("config");
    print(config);

    return config.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (configData) {
        final allIssues = configData.data?['repository']['issues']['nodes'] ?? [];
        final issues = allIssues.where((issue) {
          final labels = issue['labels']['nodes'] as List<dynamic>;
          if (_labelState.name == null) {
            return true;
          }
          return labels.any((label) => label['name'] == _labelState.name);
        }).toList();

      // print("issues");
      // print(issues);

      return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Issues'),
            actions: <Widget>[
              ElevatedButton(onPressed: () {Future(() {
                    _labelStateNotifier.setLabel("p: webview");
                  });}, 
                  child: const Text("p: webview")),
              ElevatedButton(onPressed: () {Future(() {
                    _labelStateNotifier.setLabel("p: shared_preferences");
                  });}, 
                  child: const Text("p: shared_preferences")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel("waiting for customer response");
              });}, 
              child: const Text("waiting for customer response")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel("severe: new feature");
              });}, 
              child: const Text("severe: new feature")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel("p: share");
              });}, 
              child: const Text("p: share")),
              ElevatedButton(onPressed: () {Future(() {
                _labelStateNotifier.setLabel(null);
              });}, 
              child: const Text("全て")),
            ],
          ),
          body:ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              //print(issue);
              final labels = issue['labels']['nodes'];
              // labelがついていない時空文字列を返す
              final labelName = labels.isNotEmpty ? labels[0]['name'] : '';
              return issueWidget(context, issue);
            },
          ),
        );
    },
    );
  }
}