import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/screens/home.dart';
import 'package:peeringpolicymanager/theme/theme.dart';

class Charts extends StatelessWidget {
  @override
  static const String route = '/charts';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu, color: Theme.of(context).accentColor)),
        title: Text('Peering Policy Manager'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu)),
        ],
      ),
      body: Center(
          child: RaisedButton(
              child: Text('Accept Charts')
          )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  hoverColor: Theme.of(context).accentColor.withOpacity(0.1),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Previous",
                      style:  TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
                    ),
                  ),
                )
            ),
            IconButton(icon: Icon(Icons.search), color: Theme.of(context).accentColor, onPressed: () {},),
          ],
        ),
      ),
    );
  }
}