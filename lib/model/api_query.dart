import 'package:toridori/model/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class Querymethod {
  String readRepositories = Constants.readRepositories;

  query() {
    final QueryHookResult<Object?> options = useQuery(
      QueryOptions(
      document: gql(readRepositories), 
      variables: {'owner': 'uneruby', 'repo': 'toridori'}
      )
    );
    final result = options.result;

    return result;
  }
}