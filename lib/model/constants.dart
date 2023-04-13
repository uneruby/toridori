import 'package:toridori/token.dart';

class Constants{
  static const String graphqlEndpoint = "https://api.github.com/graphql";
  static final String personalAccessToken = token.myToken;

  static const String readRepositories = """
query(\$owner:String!, \$repo:String!) {
            repository(owner:\$owner, name:\$repo) {
              issues(last:50) {
                nodes {
                  id
                  number
                  closed
                  url
                  title
                  createdAt
                  author {
                    login
                  }
                  assignees(first: 100) {
                    nodes { login name email }
                  }
                  labels(first: 100) {
                    nodes { name color }
                  }
                }
              }
            }
          }
      """;
}