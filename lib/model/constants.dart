class Constants{
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
                  body
                  comments(first: 100) {
                    nodes { 
                      id 
                      body 
                      createdAt           
                      author {
                        login
                        avatarUrl
                        ... on User {
                          name
                          email
                        }
                    }
                  }
                  }
                  author {
                    login
                    avatarUrl
                    url
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