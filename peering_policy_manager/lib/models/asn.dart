class Asn {
  String asn;
  List<RemoteNeighbors> remoteNeighbors;

  Asn({this.asn, this.remoteNeighbors});

  Asn.fromJson(Map<String, dynamic> json) {
    asn = json['asn'];
    if (json['remote_neighbors'] != null) {
      remoteNeighbors = new List<RemoteNeighbors>();
      json['remote_neighbors'].forEach((v) {
        remoteNeighbors.add(new RemoteNeighbors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asn'] = this.asn;
    if (this.remoteNeighbors != null) {
      data['remote_neighbors'] =
          this.remoteNeighbors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemoteNeighbors {
  String localIp;
  String peerIp;
  String subnet;
  String cidr;
  String interface;

  RemoteNeighbors(
      {this.localIp, this.peerIp, this.subnet, this.cidr, this.interface});

  RemoteNeighbors.fromJson(Map<String, dynamic> json) {
    localIp = json['local_ip'];
    peerIp = json['peer_ip'];
    subnet = json['subnet'];
    cidr = json['cidr'];
    interface = json['interface'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['local_ip'] = this.localIp;
    data['peer_ip'] = this.peerIp;
    data['subnet'] = this.subnet;
    data['cidr'] = this.cidr;
    data['interface'] = this.interface;
    return data;
  }
}
