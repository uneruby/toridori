import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/token.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/view/home_page.dart';

void main() async {
  runApp(
    ProviderScope(
    child: MyApp(
    // client: client,
  )));
}


class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(),
    );
  }
}
