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

    final config = ref.watch(
      useMemoized(() => FutureProvider.autoDispose<QueryResult>((ref) async {
        final queryResult = await Querymethod().query();
        print(queryResult);
        return queryResult;
      })),
    );

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

      return SafeArea(child: DefaultTabController(
        initialIndex: 0,
        length: 6,
        child: Scaffold(
          appBar: TabBar(
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.black,
          onTap: _labelStateNotifier.setLabel, 
            isScrollable: true,
            tabs: const [
              Tab(text: '全て'),
              Tab(text: 'p: webview',),
              Tab(text: 'p: shared_preferences'),
              Tab(text: 'waiting for customer response'),
              Tab(text: 'severe: new feature'),
              Tab(text: 'p: share'),
            ],
          ),
          body:ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              final labels = issue['labels']['nodes'];
              // labelがついていない時空文字列を返す
              final labelName = labels.isNotEmpty ? labels[0]['name'] : '';
              return issueWidget(context, issue);
            },
          ),
        ))
      );
    },
    );
  }
}