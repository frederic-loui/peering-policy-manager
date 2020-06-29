import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/screens/home.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/components/customCard.dart';
import 'package:peeringpolicymanager/models/router.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RoutersState extends State<Routers> {

  static String jsonString = '{"routers":["par2-003131","mrs2-003131","pis-003091","bod-003091","nte-003091","sxd-003091","ors-003091","chn-003091","rpk-003091","avn-003091","sxb-003091","pls-003091","qbq-003091","lil-003091","xcp-003091","mrs1-003091","lig-003091","rns-003091","uro-003091","ncy-003091","bre-003091","vlt-003091","tls-003091","mrs1-003131","mrs2-003091","nce-003091","cdr-003091","cte-003091","par1-003091","tuf-003091","mpl-003091","odn-003091","tln-003091","cfr-003091","evy-003091","ctl-003091","jsu-003091","joy-003091","cfe-003091","cgy-003091","ore-003091","mrn-003091","par1-003131","gnb-003091","dij-003091","pau-003091","lys-003091","par2-003091"]}';

  static Map routerMap = jsonDecode(jsonString);
  static var router = Router.fromJson(routerMap);

  final myController = new TextEditingController();

  List<String> _searchList = router.routers;


  @override
  initState() {
    myController.addListener(() {
      setState(() {
        _searchList = router.routers.where((element) => element.toLowerCase().contains(myController.text.toLowerCase())).toList();
        print("Debug element: ${router.routers.where((element) => element.toLowerCase().contains(myController.text.toLowerCase())).toString()}");
        print("Debug searchlist: ${_searchList.toString()}");
        print("Debug controller: ${myController.text}");
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;


    return new SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: "Routers",),
          body:
          new Container(
            alignment: Alignment.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                new TextField(
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0))
                      )
                  ),
                  controller: myController,
                ),
                new Expanded(
                  child : new GridView.builder(
                    itemCount: _searchList.length,
                    itemBuilder: (context, index){
                      return CustomCard(
                          ListTile(
                            leading: Icon(Icons.router),
                            title: Text(_searchList[index]),
                            subtitle: Text(router.vendor(_searchList[index])),
                          ),
                          ButtonBar()
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

class Routers extends StatefulWidget {
  @override
  static const String route = '/routers';
  RoutersState createState() => RoutersState();

}
