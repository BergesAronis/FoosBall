import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Token> authenticate(String username, String password) async {
  var url = 'https://doctor-foosy.herokuapp.com/api/api-token-auth/';
  var body = jsonEncode({ 'username': username, 'password': password});
  final response =
      await  http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Token.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    var fake = jsonEncode({'token': 'invalid'});
    return Token.fromJson(json.decode(fake));
  }
}

class Token {
  final String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'],
    );
  }
}