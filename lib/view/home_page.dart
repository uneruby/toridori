import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/model/label_state.dart';
import 'package:toridori/model/token.dart';
import 'package:toridori/model/constants.dart';
import 'package:toridori/notifier/label_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  String readRepositories = Constants.readRepositories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _labelState = ref.watch(labelProvider);
    final _labelStateNotifier = ref.watch(labelProvider.notifier);

    print(_labelState);
    return Query(
      options: QueryOptions(
        document: gql(readRepositories),
        variables: {'owner': 'uneruby', 'repo': 'toridori', 'name': _labelState.name},
      ),
      builder: (QueryResult result, {FetchMore? fetchMore, Refetch? refetch}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        final issues = result.data?['repository']['issues']['nodes'] ?? [];

        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Issues'),
          ),
          body: ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              print(issue);
              final labels = issue['labels']['nodes'];
              // labelがついていない時空文字列を返す
              final labelName = labels.isNotEmpty ? labels[0]['name'] : '';

              return ListTile(
                title: Text(issue['title']),
                subtitle: Text('by ${issue['author']['login']} label: $labelName'),
                trailing: Text(issue['createdAt']),
                onTap: () {
                  Future(() {
                    _labelStateNotifier.setLabel("bug");
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}