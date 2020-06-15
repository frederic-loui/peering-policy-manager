import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/screens/charts.dart';
import 'package:peeringpolicymanager/theme/theme.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';


class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _dashboard(),
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
                    Navigator.pushNamed(context, Charts.route);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Charts",
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

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset.zero, size.bottomRight(Offset.zero), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bad, but okay for example
    return true;
  }
}