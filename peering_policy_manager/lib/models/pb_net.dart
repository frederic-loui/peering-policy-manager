class Pb_net {
  List<Data> data;

  Pb_net({this.data});

  Pb_net.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int orgId;
  String org;
  String name;
  String aka;
  String website;
  int asn;
  String lookingGlass;
  String routeServer;
  String irrAsSet;
  String infoType;
  int infoPrefixes4;
  int infoPrefixes6;
  String infoTraffic;
  String infoRatio;
  String infoScope;
  bool infoUnicast;
  bool infoMulticast;
  bool infoIpv6;
  bool infoNeverViaRouteServers;
  String notes;
  String policyUrl;
  String policyGeneral;
  String policyLocations;
  bool policyRatio;
  String policyContracts;
  List<NetfacSet> netfacSet;
  List<NetixlanSet> netixlanSet;
  List<PocSet> pocSet;
  String created;
  String updated;
  String status;

  Data(
      {this.id,
        this.orgId,
        this.org,
        this.name,
        this.aka,
        this.website,
        this.asn,
        this.lookingGlass,
        this.routeServer,
        this.irrAsSet,
        this.infoType,
        this.infoPrefixes4,
        this.infoPrefixes6,
        this.infoTraffic,
        this.infoRatio,
        this.infoScope,
        this.infoUnicast,
        this.infoMulticast,
        this.infoIpv6,
        this.infoNeverViaRouteServers,
        this.notes,
        this.policyUrl,
        this.policyGeneral,
        this.policyLocations,
        this.policyRatio,
        this.policyContracts,
        this.netfacSet,
        this.netixlanSet,
        this.pocSet,
        this.created,
        this.updated,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgId = json['org_id'];
    org = json['org'];
    name = json['name'];
    aka = json['aka'];
    website = json['website'];
    asn = json['asn'];
    lookingGlass = json['looking_glass'];
    routeServer = json['route_server'];
    irrAsSet = json['irr_as_set'];
    infoType = json['info_type'];
    infoPrefixes4 = json['info_prefixes4'];
    infoPrefixes6 = json['info_prefixes6'];
    infoTraffic = json['info_traffic'];
    infoRatio = json['info_ratio'];
    infoScope = json['info_scope'];
    infoUnicast = json['info_unicast'];
    infoMulticast = json['info_multicast'];
    infoIpv6 = json['info_ipv6'];
    infoNeverViaRouteServers = json['info_never_via_route_servers'];
    notes = json['notes'];
    policyUrl = json['policy_url'];
    policyGeneral = json['policy_general'];
    policyLocations = json['policy_locations'];
    policyRatio = json['policy_ratio'];
    policyContracts = json['policy_contracts'];
    if (json['netfac_set'] != null) {
      netfacSet = new List<NetfacSet>();
      json['netfac_set'].forEach((v) {
        netfacSet.add(new NetfacSet.fromJson(v));
      });
    }
    if (json['netixlan_set'] != null) {
      netixlanSet = new List<NetixlanSet>();
      json['netixlan_set'].forEach((v) {
        netixlanSet.add(new NetixlanSet.fromJson(v));
      });
    }
    if (json['poc_set'] != null) {
      pocSet = new List<PocSet>();
      json['poc_set'].forEach((v) {
        pocSet.add(new PocSet.fromJson(v));
      });
    }
    created = json['created'];
    updated = json['updated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['org_id'] = this.orgId;
    data['org'] = this.org;
    data['name'] = this.name;
    data['aka'] = this.aka;
    data['website'] = this.website;
    data['asn'] = this.asn;
    data['looking_glass'] = this.lookingGlass;
    data['route_server'] = this.routeServer;
    data['irr_as_set'] = this.irrAsSet;
    data['info_type'] = this.infoType;
    data['info_prefixes4'] = this.infoPrefixes4;
    data['info_prefixes6'] = this.infoPrefixes6;
    data['info_traffic'] = this.infoTraffic;
    data['info_ratio'] = this.infoRatio;
    data['info_scope'] = this.infoScope;
    data['info_unicast'] = this.infoUnicast;
    data['info_multicast'] = this.infoMulticast;
    data['info_ipv6'] = this.infoIpv6;
    data['info_never_via_route_servers'] = this.infoNeverViaRouteServers;
    data['notes'] = this.notes;
    data['policy_url'] = this.policyUrl;
    data['policy_general'] = this.policyGeneral;
    data['policy_locations'] = this.policyLocations;
    data['policy_ratio'] = this.policyRatio;
    data['policy_contracts'] = this.policyContracts;
    if (this.netfacSet != null) {
      data['netfac_set'] = this.netfacSet.map((v) => v.toJson()).toList();
    }
    if (this.netixlanSet != null) {
      data['netixlan_set'] = this.netixlanSet.map((v) => v.toJson()).toList();
    }
    if (this.pocSet != null) {
      data['poc_set'] = this.pocSet.map((v) => v.toJson()).toList();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['status'] = this.status;
    return data;
  }
}

class NetfacSet {
  int id;
  String name;
  String city;
  String country;
  int facId;
  String fac;
  int localAsn;
  String created;
  String updated;
  String status;

  NetfacSet(
      {this.id,
        this.name,
        this.city,
        this.country,
        this.facId,
        this.fac,
        this.localAsn,
        this.created,
        this.updated,
        this.status});

  NetfacSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    country = json['country'];
    facId = json['fac_id'];
    fac = json['fac'];
    localAsn = json['local_asn'];
    created = json['created'];
    updated = json['updated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['country'] = this.country;
    data['fac_id'] = this.facId;
    data['fac'] = this.fac;
    data['local_asn'] = this.localAsn;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['status'] = this.status;
    return data;
  }
}

class NetixlanSet {
  int id;
  String ixId;
  String name;
  String ixlanId;
  String ixlan;
  String notes;
  int speed;
  int asn;
  String ipaddr4;
  String ipaddr6;
  bool isRsPeer;
  String created;
  String updated;
  String status;

  NetixlanSet(
      {this.id,
        this.ixId,
        this.name,
        this.ixlanId,
        this.ixlan,
        this.notes,
        this.speed,
        this.asn,
        this.ipaddr4,
        this.ipaddr6,
        this.isRsPeer,
        this.created,
        this.updated,
        this.status});

  NetixlanSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ixId = json['ix_id'];
    name = json['name'];
    ixlanId = json['ixlan_id'];
    ixlan = json['ixlan'];
    notes = json['notes'];
    speed = json['speed'];
    asn = json['asn'];
    ipaddr4 = json['ipaddr4'];
    ipaddr6 = json['ipaddr6'];
    isRsPeer = json['is_rs_peer'];
    created = json['created'];
    updated = json['updated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ix_id'] = this.ixId;
    data['name'] = this.name;
    data['ixlan_id'] = this.ixlanId;
    data['ixlan'] = this.ixlan;
    data['notes'] = this.notes;
    data['speed'] = this.speed;
    data['asn'] = this.asn;
    data['ipaddr4'] = this.ipaddr4;
    data['ipaddr6'] = this.ipaddr6;
    data['is_rs_peer'] = this.isRsPeer;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['status'] = this.status;
    return data;
  }
}

class PocSet {
  int id;
  String role;
  String visible;
  String name;
  String phone;
  String email;
  String url;
  String created;
  String updated;
  String status;

  PocSet(
      {this.id,
        this.role,
        this.visible,
        this.name,
        this.phone,
        this.email,
        this.url,
        this.created,
        this.updated,
        this.status});

  PocSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    visible = json['visible'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    url = json['url'];
    created = json['created'];
    updated = json['updated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['visible'] = this.visible;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['url'] = this.url;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['status'] = this.status;
    return data;
  }
}
