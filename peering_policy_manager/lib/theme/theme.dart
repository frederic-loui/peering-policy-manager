import 'package:flutter/material.dart';

class MyTheme
{
  static final ThemeData whiteTheme = _buildWhiteTheme();
  static final ThemeData indigoTheme = _buildIndigoTheme();


  static final Image logo = new Image(
      image: new ExactAssetImage("../assets/renater_logo.jpg"),
      height: 20.0,
      width: 20.0,
      alignment: FractionalOffset.center);

  static ThemeData _buildWhiteTheme(){
    return  ThemeData(
      primaryColor: Colors.white,
    );
  }

  static ThemeData _buildIndigoTheme()
  {
    return ThemeData(
      // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.indigo[800],
        accentColor: Colors.white,

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        )
    );
  }

  static Divider buildCustomDivider()
  {
    return Divider(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      height: 10,
      thickness: 5,
      indent: 0,
      endIndent: 0,
    );
  }


}