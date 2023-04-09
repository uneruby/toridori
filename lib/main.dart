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
          primarySwatch: Colors.deepPurple,
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

  FetchMoreOptions fetchMoreData(Map<String, dynamic> pageInfo) {
    final String fetchMoreCursor = pageInfo['endCursor'];
    FetchMoreOptions opts = FetchMoreOptions(
      variables: {'cursor': fetchMoreCursor},
      updateQuery: (previousResultData, fetchMoreResultData) {
        final List<dynamic> repos = [
          ...previousResultData?['user']['repositories']['edges']
              as List<dynamic>,
          ...fetchMoreResultData?['user']['repositories']['edges']
              as List<dynamic>
        ];

        fetchMoreResultData?['user']['repositories']['edges'] = repos;

        return fetchMoreResultData;
      },
    );

    return opts;
  }

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Github Demo App');
  final TextEditingController userNameTextEditingController =
      TextEditingController(text: "uneruby");

  PreferredSizeWidget appBar(){
    return AppBar(
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextFormField(
                      cursorColor: Colors.white,
                      controller: userNameTextEditingController,
                      decoration: const InputDecoration(
                        hintText: 'type userId...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onEditingComplete: () {
                        setState(() {});
                      }),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = const Text('My Github Demo App');
              }
            });
          },
          icon: customIcon,
        )
      ],
      centerTitle: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    debugPrint(readRepositories);
    return Query(
      options: QueryOptions(
        document: gql(readRepositories),
        variables: {'owner': 'uneruby', 'repo': 'toridori'},
      ),
      builder: (QueryResult result, {FetchMore? fetchMore, Refetch? refetch}) {
        if (result.hasException) {
          print(result.exception);
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          print(result);
          return CircularProgressIndicator();
        }

        final issues = result.data?['repository']['issues']['nodes'] ?? [];
        print(issues);

        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Issues'),
          ),
          body: ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];

              return ListTile(
                title: Text(issue['title']),
                subtitle: Text('by ${issue['author']['login']}'),
                trailing: Text(issue['createdAt']),
              );
            },
          ),
        );
      },
    );
  }
}