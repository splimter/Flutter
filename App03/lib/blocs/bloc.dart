import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validator {
  final _email = BehaviorSubject<String>();
  final _pwd = BehaviorSubject<String>();

  //Add data to Stream
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get pwd => _pwd.stream.transform(validatePwd);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, pwd, (e, p) => true);

  //change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePwd => _pwd.sink.add;

  submit(){
    final validEmail = _email.value;
    final validPwd = _pwd.value;
    print('Email is $validEmail && password is $validPwd');
  }

  dispose() {
    _email.close();
    _pwd.close();
  }
}
