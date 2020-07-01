import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:peeringpolicymanager/screens/charts.dart';
import 'package:peeringpolicymanager/screens/routerscr.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/screens/home.dart';
import 'package:peeringpolicymanager/screens/routers.dart';
import 'package:peeringpolicymanager/screens/webtree.dart';
import 'package:peeringpolicymanager/routes/routes.dart';
import 'package:peeringpolicymanager/screens/pagenotfound.dart';

import 'package:url_launcher/url_launcher.dart';

// API http://ix1-dv-u18-PeeringsPolicyTools-01.renater.fr:8080
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.indigoTheme,
      // Root route, dashboard
      initialRoute: '/',
      onUnknownRoute: (settings) {  return MaterialPageRoute(builder: (_) => PageNotFound());},
      routes: {
        // When navigating to the "/" route, build the Dashboard widget.
        Routes.home: (context) => Dashboard(),
        Routes.charts: (context) => Charts(),
        Routes.routers: (context) => Routers(),
        Routes.webtree: (context) => WebTree(),
        Routes.routerscr: (context) => RouterScr(),

        // When navigating to the "/test" route, build the Test Widget
        // '/test': (context) => Test(),
      },
    );
  }

}

