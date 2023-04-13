import 'package:flutter/material.dart';
import 'package:toridori/model/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/token.dart';


class Querymethod {
  String readRepositories = Constants.readRepositories;

Future query() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink('https://api.github.com/graphql');

  final String myToken = token.myToken;

  final AuthLink authLink = AuthLink(
    getToken: () async => myToken,
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  final result = await client.value.query(QueryOptions(
    document: gql(readRepositories),
    variables: {'owner': 'uneruby', 'repo': 'toridori'},
  ));

  return result;
}
  }