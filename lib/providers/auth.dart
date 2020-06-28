import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{

  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email , String password)async{
    const webKey = '';
    const url = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$webKey';
    final response = await http.post(url,body: jsonEncode({
      'email' : email,
      'password' : password,
      'returnSecureToken': true,
    }));
  }

}