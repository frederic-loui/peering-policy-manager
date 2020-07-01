import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/screens/charts.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customDrawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:peeringpolicymanager/routes/routes.dart';

class WebTreeState extends State<WebTree> {
  @override
  Widget build(BuildContext context) {

    if (Theme.of(context).platform == TargetPlatform.macOS)
    {
      _launchURL();
      Navigator.pop(context);
    }

    return SafeArea(
      child:Scaffold(
        appBar: CustomAppBar(title: "Peering Policy Manager",),
        drawer: CustomDrawer(),
        body:
          new WebView(
            initialUrl: 'http://ix1-dv-u18-peeringspolicytools-01.renater.fr/ppm/indented-tree/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        bottomNavigationBar: CustomBottomNavigationBar(route: Charts.route, pop: false, left_button: "Charts",),
      ),
    );
  }
}


class WebTree extends StatefulWidget {
  @override
  static const String route = '/webtree';
  WebTreeState createState() => WebTreeState();
}

_launchURL() async {
  const url = 'http://ix1-dv-u18-peeringspolicytools-01.renater.fr/ppm/indented-tree/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}







