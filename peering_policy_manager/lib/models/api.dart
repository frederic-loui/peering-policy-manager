import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:peeringpolicymanager/models/router.dart';

class API {
  final String postsURL = "http://ix1-dv-u18-peeringspolicytools-01.renater.fr:8080/api";
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
      return Router.fromJson(json.decode(response.body.replaceAll("\'", '"')));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Failed");
      throw Exception('Failed to load routers');
    }
  }
}