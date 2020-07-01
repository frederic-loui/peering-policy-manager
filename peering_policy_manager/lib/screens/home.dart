import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/screens/charts.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customDrawer.dart';

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          appBar: CustomAppBar(title: "Peering Policy Manager",),
          drawer: CustomDrawer(),
          body: _dashboard(),
          bottomNavigationBar: CustomBottomNavigationBar(route: Charts.route, pop: false, left_button: "Charts",),
        ),
    );
  }

  Widget _dashboard() {
    Container container_test = new Container(
      child: new Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(40),
          onTap: () {
            print('Card Tapped');
          },
        ),
      ),
    );
  }
}


class Dashboard extends StatefulWidget {
  @override
  static const String route = '/';
  DashboardState createState() => DashboardState();
}