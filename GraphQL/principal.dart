import "package:flutter/material.dart";
import 'package:fooddelivery/person.dart';
import 'package:fooddelivery/queryMutation.dart';
import "package:graphql_flutter/graphql_flutter.dart";
import 'alertDialogs.dart';
import 'graphQLConf.dart';

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Principal();
}

class _Principal extends State<Principal> {
  List<Person> listPerson = List<Person>();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  void fillList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client
        .query(
      QueryOptions(
        document: queryMutation.getAll(),
      ),
    )
        .catchError((error) {
      print('''Error => $error''');
      return false;
    });
    print('_client: $_client');
    if (!result.hasException) {
      LazyCacheMap queryName = (result.data as LazyCacheMap).get('allPersons');
      List<Object> queryData = queryName.get('data');

      queryData.forEach((key) {
      	print('${ (key as LazyCacheMap)["_id"] }');
				setState(() {
					listPerson.add(
						Person(
							(key as LazyCacheMap)["_id"],
							(key as LazyCacheMap)["id"],
							(key as LazyCacheMap)["name"],
							(key as LazyCacheMap)["lastName"],
							(key as LazyCacheMap)["age"],
						),
					);
				});
      });


      return;
    }
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }

  void _addPerson(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: true);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listPerson.clear();
      fillList();
    });
  }

  void _editDeletePerson(context, Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: false, person: person);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listPerson.clear();
      fillList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _addPerson(context),
            tooltip: "Insert new person",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Person",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              itemCount: listPerson.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: listPerson == null ? false : true,
                  title: Text(
                    "${listPerson[index].getName()}",
                  ),
                  onTap: () {
                    _editDeletePerson(context, listPerson[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
