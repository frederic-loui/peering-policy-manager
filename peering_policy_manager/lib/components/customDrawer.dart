import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/routes/routes.dart';


class CustomDrawer extends StatelessWidget {

  CustomDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
      margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
              image: DecorationImage(
                  image:  AssetImage('renater-icon.png'))),
          child: Stack(children: <Widget>[
            Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text("PEERING POLICY MANAGER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))),
          ])),
          _createDrawerItem(icon: Icons.home, text: 'Home', onTap: () => Navigator.pushNamed(context, Routes.home),),
          _createDrawerItem(icon: Icons.router, text: 'Routers', onTap: () => Navigator.pushNamed(context, Routes.routers),),
          _createDrawerItem(icon: Icons.texture, text: 'Charts', onTap: () => Navigator.pushNamed(context, Routes.charts),),
          _createDrawerItem(icon: Icons.streetview, text: 'Web Tree Peering', onTap: () => Navigator.pushNamed(context, Routes.webtree),),

          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


