import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_adapter.dart' as result;
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart' as route;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  String massage = '';
  final num = TextEditingController();
  void _fetchPosts(String x) async {
    final response = await http.post('http://10.0.2.2:8000/check/',
        body: jsonEncode(
          {'num': x},
        ));

    if (response.statusCode == 200) {
      setState(() {
        massage = result.parseJson(response.body);
      });
      print(massage);
    } else {
      setState(() {
        massage = '통신오류';
        print(massage);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("출석체크")),
      body: Container(
        child: TextField(
          style: TextStyle(fontSize: 40.0, height: 2.0, color: Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp('[0-9]')),
          ],
          decoration: InputDecoration(
            labelText: massage,
            hintText: '',
          ),
          onChanged: (value) {},
          controller: num,
          onSubmitted: (value) {
            _fetchPosts(num.text);
            // route.showFlushbar(context: context, flushbar: _flushbar);
            // print(massage);
            num.clear();
            // num.text = this.massage;
          },
        ),
      ),
    );
  }
}
