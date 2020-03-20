import "package:flutter/material.dart";
import 'package:fooddelivery/person.dart';
import 'package:fooddelivery/queryMutation.dart';
import "package:graphql_flutter/graphql_flutter.dart";

import 'graphQLConf.dart';

class AlertDialogWindow extends StatefulWidget {
	final Person person;
	final bool isAdd;

	AlertDialogWindow({Key key, this.person, this.isAdd}) : super(key: key);

	@override
	State<StatefulWidget> createState() =>
			_AlertDialogWindow(this.person, this.isAdd);
}

class _AlertDialogWindow extends State<AlertDialogWindow> {
	TextEditingController txtId = TextEditingController();
	TextEditingController txtName = TextEditingController();
	TextEditingController txtLastName = TextEditingController();
	TextEditingController txtAge = TextEditingController();
	GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
	QueryMutation addMutation = QueryMutation();

	final Person person;
	final bool isAdd;
	String _gqlId;

	_AlertDialogWindow(this.person, this.isAdd);

	@override
	void initState() {
		super.initState();
		if (!this.isAdd) {
			_gqlId = person.getGQLId();
			txtId.text = person.getId();
			txtName.text = person.getName();
			txtLastName.text = person.getLastName();
			txtAge.text = person.getAge();
		}
	}

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		return AlertDialog(
			title: Text(this.isAdd ? "Add" : "Edit or Delete"),
			content: Container(
				child: SingleChildScrollView(
					child: ConstrainedBox(
						constraints: BoxConstraints(
							maxWidth: MediaQuery.of(context).size.width,
						),
						child: Stack(
							children: <Widget>[
								Container(
									child: TextField(
										maxLength: 5,
										controller: txtId,
										enabled: this.isAdd,
										decoration: InputDecoration(
											icon: Icon(Icons.perm_identity),
											labelText: "ID",
										),
									),
								),
								Container(
									padding: EdgeInsets.only(top: 80.0),
									child: TextField(
										maxLength: 40,
										controller: txtName,
										decoration: InputDecoration(
											icon: Icon(Icons.text_format),
											labelText: "Name",
										),
									),
								),
								Container(
									padding: EdgeInsets.only(top: 160.0),
									child: TextField(
										maxLength: 40,
										controller: txtLastName,
										decoration: InputDecoration(
											icon: Icon(Icons.text_rotate_vertical),
											labelText: "Last name",
										),
									),
								),
								Container(
									padding: EdgeInsets.only(top: 240.0),
									child: TextField(
										maxLength: 2,
										controller: txtAge,
										keyboardType: TextInputType.number,
										decoration: InputDecoration(
												labelText: "Age", icon: Icon(Icons.calendar_today)),
									),
								),
							],
						),
					),
				),
			),
			actions: <Widget>[
				FlatButton(
					child: Text("Close"),
					onPressed: () => Navigator.of(context).pop(),
				),
				!this.isAdd
						? FlatButton(
					child: Text("Delete"),
					onPressed: () async {
						GraphQLClient _client = graphQLConfiguration.clientToQuery();
						QueryResult result = await _client.mutate(
							MutationOptions(
								document: addMutation.deletePerson(_gqlId),
							),
						);
						if (!result.hasException) {Navigator.of(context).pop();}
						else{print('result ${result.exception}');}
					},
				)
						: null,
				FlatButton(
					child: Text(this.isAdd ? "Add" : "Edit"),
					onPressed: () async {
						if (txtId.text.isNotEmpty &&
								txtName.text.isNotEmpty &&
								txtLastName.text.isNotEmpty &&
								txtAge.text.isNotEmpty) {
							if (this.isAdd) {
								GraphQLClient _client = graphQLConfiguration.clientToQuery();
								QueryResult result = await _client.mutate(
									MutationOptions(
										document: addMutation.addPerson(
											txtId.text.trim(),
											txtName.text.trim(),
											txtLastName.text.trim(),
											txtAge.text.trim(),
										),
									),
								);
								if (!result.hasException) {
									txtId.clear();
									txtName.clear();
									txtLastName.clear();
									txtAge.clear();
									Navigator.of(context).pop();
								}else{print('result ${result.exception}');}
							} else {
								GraphQLClient _client = graphQLConfiguration.clientToQuery();
								QueryResult result = await _client.mutate(
									MutationOptions(
										document: addMutation.editPerson(
											_gqlId,
											txtId.text,
											txtName.text,
											txtLastName.text,
											int.parse(txtAge.text),
										),
									),
								);
								if (!result.hasException) {
									txtId.clear();
									txtName.clear();
									txtLastName.clear();
									txtAge.clear();
									Navigator.of(context).pop();
								}else{print('result ${result.exception}');}
							}
						}
					},
				)
			],
		);
	}
}