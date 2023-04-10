class Constants{

  static const String readRepositories = """
query(\$owner:String!, \$repo:String!, \$name: String!) {
            repository(owner:\$owner, name:\$repo) {
              issues(last:50 labels:[\$name]) {
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