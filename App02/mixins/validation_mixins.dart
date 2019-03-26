import 'package:flutter/material.dart';
class ValidationMixin {
  String validateEmail(value) {
    if (!value.contains('@'))
      return 'Please enter a valid email';
    return null;
  }

  String validatePwd(value) {
    if (value.length < 4)
      return 'Please enter a valid password';
    return null;
  }

}