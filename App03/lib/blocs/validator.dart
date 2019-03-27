import 'dart:async';

class Validator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@'))
      sink.add(email);
    else
      sink.addError('Enter a valid email');
  });

  final validatePwd =
      StreamTransformer<String, String>.fromHandlers(handleData: (pwd, sink) {
    if (pwd.length > 4)
      sink.add(pwd);
    else
      sink.addError('Enter a valid password');
  });
}
