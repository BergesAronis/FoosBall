import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Post> fetchPost() async {
  var url = 'http://127.0.0.1:8000/api/api-token-auth/';
  var body = jsonEncode({ 'username': 'admin', 'password':'1234pass'});
  final response =
      await  http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );



  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response);
    print(response.body);
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String token;

  Post({this.token});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      token: json['token'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.token);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

