import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/screens/home.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/components/customCard.dart';
import 'package:peeringpolicymanager/models/router.dart';
import 'package:peeringpolicymanager/routes/routes.dart';
import 'package:peeringpolicymanager/models/asn.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RouterState extends State<RouterScr> {
  static String jsonString = '[{"asn": "2445", "remote_neighbors": [{"local_ip": "193.51.186.29", "peer_ip": "193.51.186.29", "subnet": "193.51.186.28", "cidr": "30", "interface": "TenGigE0/0/0/1.200"}, {"local_ip": "2001:660:3000:1000:10:0:6:5052", "peer_ip": "2001:660:3000:1000:10:0:6:5052", "subnet": "2001:660:3000:1000::", "cidr": "64", "interface": "TenGigE0/0/0/1.200"}]}]';
  static final jsonresponse = json.decode(jsonString);

  static var asn = Asn.fromJson(jsonresponse[0]);

  @override
  Widget build(BuildContext context) {

    String args = ModalRoute.of(context).settings.arguments;

    if(args == null)
      {
        args = "Not found";
      }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Router $args",),
        body:
        new Container(
          alignment: Alignment.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Divider(color: Colors.grey,
                  height: 1,
                  thickness: 1),
              new Expanded(
                child : new GridView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return CustomCard(
                        title: asn.asn,
                        subtitle: "",
                        leading: Icons.router,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(pop: true, left_button: "Previous",),
      )
    );
  }
}

class RouterScr extends StatefulWidget {

  static const String route = '/router';

  @override
  RouterState createState() => RouterState();

}
