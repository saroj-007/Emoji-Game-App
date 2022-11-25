
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class UserValidator extends ChangeNotifier {

  bool isValid = false;

  void emailValidate(String email) {
    isValid = EmailValidator.validate(email);
    print(isValid);
    notifyListeners();
  }
}