import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/model/token.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/view/home_page.dart';

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink('https://api.github.com/graphql');

  const String myToken = Token.myToken;

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

  runApp(
    ProviderScope(
    child: MyApp(
    client: client,
  )));
}


class MyApp extends ConsumerWidget {
  ValueNotifier<GraphQLClient> client;

  MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
