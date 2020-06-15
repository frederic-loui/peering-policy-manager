import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:peeringpolicymanager/screens/charts.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.indigoTheme,
      // Root route, dashboard
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the Dashboard widget.
        Dashboard.route: (context) => Dashboard(),
        Charts.route: (context) => Charts(),

        // When navigating to the "/test" route, build the Test Widget
        // '/test': (context) => Test(),
      },

    );
  }
}

