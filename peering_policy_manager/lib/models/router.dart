class Router {
  List<String> routers;


  Router({this.routers});

  Router.fromJson(Map<String, dynamic> json) {
    routers = json['routers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routers'] = this.routers;
    return data;
  }

  String convertToName(String routershortname)
  {


  }
// All fields are escaped with double quotes. This method deals with them
  static String unescapeString(dynamic value) {

    return null;
  }

  String vendor(String routershortname)
  {
    RegExp regExp = new RegExp(
      r"[0-9]{3}$",
      caseSensitive: false,
      multiLine: false,
    );
    String vendorCode = regExp.stringMatch(routershortname).toString();

    if (vendorCode == "131")
      {
        return "JUNIPER MX2010";
      }
    else if (vendorCode == "091")
      {
        return "CISCO ASR 9K";
      }
    else return "Unknown";
  }


}