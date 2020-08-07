import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:peeringpolicymanager/models/pb_net.dart';
import 'package:peeringpolicymanager/models/router.dart';
import 'package:peeringpolicymanager/models/asn.dart';

class API {
  final String postsURL = "http://ix1-dv-u18-peeringspolicytools-01.renater.fr:8080/api";
  final String postsPbURL = "https://www.peeringdb.com/api";
  final Map<String, String> headers = {"Accept":"application/json", "Access-Control-Allow-Origin":"*", "Access-Control-Allow-Methods":"POST,GET,DELETE,PUT,OPTIONS"};

  Future<Router> fetchRouters() async {
    String routerUrl = postsURL+"/routers";
    print("URL $routerUrl");
    final response =
    await http.get(routerUrl, headers: headers);
    print("Await API");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("OK");
      //TODO Change API JSON to march correctly
      return Router.fromJson(json.decode(response.body.replaceAll("\'", '"')));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Failed");
      throw Exception('Failed to load routers');
    }
  }

  Future<List<Asn>> fetchAsnByRouter(String routername) async {
    String routerUrl = postsURL+"/peers/"+routername;
    print("URL $routerUrl");
    final response =
    await http.get(routerUrl, headers: headers);
    print("Await API (fetchAsnByRouter)");
    if (response.statusCode == 200) {
      List<Asn> listAsnModel = [];
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("OK (fetchAsnByRouter)");
      for(Map i in json.decode(response.body.replaceAll("\'", '"'))){
        print(Asn.fromJson(i).asn);
        listAsnModel.add(Asn.fromJson(i));
        print("Map of ASN $i OK");
      }
      print("Map of all ASN OK");
      return listAsnModel;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Failed");
      throw Exception('Failed to load ASN by router name');
    }
  }

  Future<Pb_net> fetchPbNetByAsn(String asn) async {
    String fetchPbNetByAsnUrl = postsPbURL+"/net?asn__in="+asn;
    print("URL $fetchPbNetByAsnUrl (fetchPbNetByAsn)");
    final response =
    await http.get(fetchPbNetByAsnUrl, headers: headers);
    print("Await API (fetchPbNetByAsn)");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("OK (fetchPbNetByAsn)");
      //TODO Change API JSON to march correctly
      print("Pb_net.fromJson(json.decode(response.body))");
      print(json.decode(response.body));
      return Pb_net.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Failed");
      throw Exception('Failed to load Peering DB by ASN');
    }
  }
}