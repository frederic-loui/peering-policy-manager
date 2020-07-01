import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData leading;

  CustomCard({Key key, this.title, this.subtitle, this.leading}) : super(key: key);


  @override
  CustomCardState createState() => CustomCardState();

}

class CustomCardState extends State<CustomCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(widget.leading),
              title: Text(widget.title),
              subtitle: Text(widget.subtitle),
            ),
          ],
        ),
      ),
    );
  }
}