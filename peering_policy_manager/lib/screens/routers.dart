import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/components/customCard.dart';
import 'package:peeringpolicymanager/models/router.dart';
import 'package:peeringpolicymanager/models/api.dart';
import 'package:peeringpolicymanager/routes/routes.dart';

import 'package:flutter/foundation.dart' show kIsWeb;


class RoutersState extends State<Routers> {

  final myController = new TextEditingController();
  final API api = API();

  List<String> _searchList;
  Future<Router> futureRouter;
  Router routers;


  @override
  initState() {
    super.initState();
    futureRouter = api.fetchRouters();
    futureRouter.then((result)
    {
      setState(() {
        routers = result;
        _searchList = routers.routers;
        print("Debug searchlist $_searchList");
      });
    }
    );

    myController.addListener(() {
      setState(() {
        _searchList = routers.routers.where((element) => element.toLowerCase().contains(myController.text.toLowerCase()) || routers.vendor(element).toLowerCase().contains(myController.text.toLowerCase())).toList();
        print("Debug element: ${routers.routers.where((element) => element.toLowerCase().contains(myController.text.toLowerCase())).toString()}");
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

      return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(title: "Routers",),
            body:
            new FutureBuilder<Router>(
                future: futureRouter,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(20.0),
                            child: new Material(
                              elevation: 5.0,
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: "Search",
                                    hintText: "Search a router",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))
                                    )
                                ),
                                controller: myController,
                              ),
                            ),

                          ),
                          new Divider(color: Colors.grey,
                              height: 1,
                              thickness: 1),
                          new Expanded(
                            child: new GridView.builder(
                              itemCount: _searchList.length,
                              itemBuilder: (context, index) {
                                return new InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                      Routes.routerscr,
                                      arguments: _searchList[index],
                                    );
                                  },
                                  child: CustomCard(
                                    title: _searchList[index],
                                    subtitle: routers.vendor(
                                        _searchList[index]),
                                    leading: Icons.router,
                                  ),
                                );
                              },
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              pop: true, left_button: "Previous",),
          )
      );
    }
  }


class Routers extends StatefulWidget {
  @override
  static const String route = '/routers';
  RoutersState createState() => RoutersState();

}
