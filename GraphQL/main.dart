import 'package:flutter/material.dart';
import 'package:fooddelivery/principal.dart';
import "package:graphql_flutter/graphql_flutter.dart";
import 'graphQLConf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( GraphQLProvider(
    client: graphQLConfiguration.client,
    child: CacheProvider(child: MyApp()),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Principal(),
    );
  }
}