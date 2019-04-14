import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Stats> fetchStats(String token) async {
  var url = 'https://doctor-foosy.herokuapp.com/games/';
  var headers = {"Content-Type": "application/json",
                "Authorization" : "Token " + token};
  final response =
      await  http.post(url,
      headers: headers,
  );

  
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Stats.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    var fake = jsonEncode({'token': 'invalid'});
    return Stats.fromJson(json.decode(fake));
  }
}

class Stats {
  final String name;
  final int score;

  Stats({this.score, this.name});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      score: json['score'],
      name: json['name'],
    );
  }
}