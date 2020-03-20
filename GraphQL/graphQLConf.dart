import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {

	static HttpLink _httpLink = HttpLink(
		uri: "GRAPHQL_API_URL",
		headers: <String, String>{
			'Authorization': 'PERSONAL_KEY_IF_EXIST',
		},
	);

	ValueNotifier<GraphQLClient> client = ValueNotifier(
		GraphQLClient(
			link: _httpLink,
			cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
		),
	);

	GraphQLClient clientToQuery() {
		return GraphQLClient(
			cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
			link: _httpLink,
		);
	}
}