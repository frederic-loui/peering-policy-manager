import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/screens/home.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/components/customDrawer.dart';

class Charts extends StatelessWidget {
  @override
  static const String route = '/charts';
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: "Charts",),
          body: Center(
              child: RaisedButton(
                  child: Text('Accept Charts')
              )
          ),
          bottomNavigationBar: CustomBottomNavigationBar(pop: true, left_button: "Previous",),
        ),
    );
  }
}