import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final String route;
  final bool pop;
  final String left_button;

  CustomBottomNavigationBar({this.route, this.pop, this.left_button});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  if(pop)
                    {
                      Navigator.pop(context);
                    } else {
                    Navigator.pushNamed(context, route);
                  }

                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(left_button,
                    style:  TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
                  ),
                ),
              )
          ),
          IconButton(icon: Icon(Icons.search), color: Theme.of(context).accentColor, onPressed: () {},),
        ],
      ),
    );
  }
}


