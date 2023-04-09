class Constants{

  static const String readRepositories = """
query(\$owner:String!, \$repo:String!) {
            repository(owner:\$owner, name:\$repo) {
              issues(last:50) {
                nodes {
                  title
                  createdAt
                  author {
                    login
                  }
                }
              }
            }
          }
      """;
}