import 'package:flutter/material.dart';
import 'package:peeringpolicymanager/components/customAppBar.dart';
import 'package:peeringpolicymanager/components/customBottomNavigationBar.dart';
import 'package:peeringpolicymanager/models/asn.dart';
import 'package:peeringpolicymanager/models/api.dart';
import 'dart:js' as js;

import 'dart:async';


class RouterState extends State<RouterScr> {
  final API api = API();

  Future<List<Asn>> futureAsn;
  List<Asn> asn_vals;

  @override
  initState() {
    super.initState();
      //Get ASN peers by router name
      futureAsn = api.fetchAsnByRouter("par2-003131");
      futureAsn.then((result)
      {
        asn_vals = result;
        print("Debug asn_val "+ asn_vals[0].asn.toString());
      });
    }

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
          new FutureBuilder<List<Asn>>(
              future: futureAsn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new SingleChildScrollView(
                      padding: EdgeInsets.all(30),
                      child: Container(
                          child : ExpansionTile(
                            title: Text("ASN Peers",),
                            children : getParentTreeAS(asn_vals, context),
                          )
                      )
                  );
                }
                else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
          ),
          bottomNavigationBar: CustomBottomNavigationBar(pop: true, left_button: "Previous",),
        )
    );
  }
}

List<Widget> getParentTreeAS(List<Asn> asns, var context)
{
  print(asns.toString());
  List<Widget> listParentTree = new List<Widget>();
  List<Widget> listasn = new List<Widget>();
  for(var asn_length = 0; asn_length < asns.length; asn_length++) {
    listParentTree = getParentTree(asns[asn_length].remoteNeighbors);
    listParentTree.add(Padding(
        padding: EdgeInsets.only(left: 30),
        child: ListTile(
          title: new Text("Peering DB "+asns[asn_length].asn),
          onTap: () { _launchURL("https://www.peeringdb.com/search?q="+asns[asn_length].asn); },
        )
    ));

    listasn.add(
        new Padding(
          padding: EdgeInsets.only(left: 30),
          child: ExpansionTile(
        backgroundColor: Theme
            .of(context)
            .accentColor
            .withOpacity(0.050),
      title: Text("   "+asns[asn_length].asn),
      children: listParentTree
      ),
    ));


  }
  return listasn;
}

List<Widget> getParentTree(List<RemoteNeighbors> rn)
{
  List<Widget> listrn = new List<Widget>();
  for(var y = 0; y < rn.length; y++){
    listrn.add(
      new Padding(
          padding: EdgeInsets.only(left: 30),
          child: ExpansionTile(
        title: Text("Remote Neighbor " + (y + 1).toString()),
        children: getChildTree(rn[y]),
      )
    ));

  }


  return listrn;
}

List<Widget> getChildTree(RemoteNeighbors rn)
{
  List<Widget> listrnvalue = new List<Widget>();

  listrnvalue.add(
      Padding(
        padding: EdgeInsets.only(left: 30),
        child: ListTile(
            title: Text("Subnet : " + rn.subnet + "/" + rn.cidr),
      )
  ));

  listrnvalue.add(
      Padding(
          padding: EdgeInsets.only(left: 30),
          child: ListTile(
          title: Text("Peer IP : " + rn.peerIp),
      ))
  );

  listrnvalue.add(
      Padding(
          padding: EdgeInsets.only(left: 30),
          child: ListTile(
          title: Text("Local IP : " + rn.localIp),
        )
      ));

  listrnvalue.add(
      Padding(
          padding: EdgeInsets.only(left: 30),
          child: ListTile(
          title: Text("Interface : " + rn.interface),
        )
      ));

  return listrnvalue;
}

_launchURL(url) {
  js.context.callMethod("open", [url]);
}

class RouterScr extends StatefulWidget {

  static const String route = '/router';

  @override
  RouterState createState() => RouterState();

}
