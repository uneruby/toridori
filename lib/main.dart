import 'package:flutter/material.dart';
import 'package:toridori/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toridori/token.dart';

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

  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  ValueNotifier<GraphQLClient> client;

  MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String readRepositories = Constants.readRepositories;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(readRepositories),
        variables: {'owner': 'uneruby', 'repo': 'toridori'},
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
              final labels = issue['labels']['nodes'];
              // labelがついていない時空文字列を返す
              final labelName = labels.isNotEmpty ? labels[0]['name'] : '';

              return ListTile(
                title: Text(issue['title']),
                subtitle: Text('by ${issue['author']['login']} label: $labelName'),
                trailing: Text(issue['createdAt']),
              );
            },
          ),
        );
      },
    );
  }
}