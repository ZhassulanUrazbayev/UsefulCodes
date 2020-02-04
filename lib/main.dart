import 'package:flutter/material.dart';
import 'package:flutter_json/models/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(
        title: 'Users',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: missing_return
  Future<List<User>> _getUser() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user =
          User(u["index"], u["about"], u["name"], u["email"], u["picture"]);

      users.add(user);
    }

    print(users.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].name),
                );
              },
            );
          }
          },
        ),
      ),
    );
  }
}
