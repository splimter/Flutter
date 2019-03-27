import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          pwdField(bloc),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
/*          onChanged: (newVal) {
            bloc.changeEmail(newVal);
          },*/
          onChanged:  bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@exemple.com',
            labelText: 'Email Adress',
            //errorText: 'Invalid Email',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget pwdField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.pwd,
      builder: (context, snapshot){
        return TextField(
          onChanged:  bloc.changePwd,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );

  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot){
        return RaisedButton(
          child: Text('Login'),
          color: Colors.blueAccent,
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );

  }
}
