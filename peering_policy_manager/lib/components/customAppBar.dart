import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.menu, color: Theme.of(context).accentColor)),
      title: Text('Peering Policy Manager'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.tune)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


