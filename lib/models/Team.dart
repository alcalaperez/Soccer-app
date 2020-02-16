class Team {
  int id;
  Area area;
  String name;
  String shortName;
  String tla;
  String crestUrl;
  String address;
  String phone;
  String website;
  String email;
  int founded;
  String clubColors;
  String venue;
  List<Squad> squad;
  String lastUpdated;

  Team(
      {this.id,
      this.area,
      this.name,
      this.shortName,
      this.tla,
      this.crestUrl,
      this.address,
      this.phone,
      this.website,
      this.email,
      this.founded,
      this.clubColors,
      this.venue,
      this.squad,
      this.lastUpdated});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    if (json['squad'] != null) {
      squad = new List<Squad>();
      json['squad'].forEach((v) {
        squad.add(new Squad.fromJson(v));
      });
    }
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.area != null) {
      data['area'] = this.area.toJson();
    }
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['tla'] = this.tla;
    data['crestUrl'] = this.crestUrl;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['email'] = this.email;
    data['founded'] = this.founded;
    data['clubColors'] = this.clubColors;
    data['venue'] = this.venue;
    if (this.squad != null) {
      data['squad'] = this.squad.map((v) => v.toJson()).toList();
    }
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

class Area {
  int id;
  String name;

  Area({this.id, this.name});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Squad {
  int id;
  String name;
  String position;
  String dateOfBirth;
  String countryOfBirth;
  String nationality;
  String role;
  String shirtNumber;
  String yearsOld;
  String flag;

  Squad(
      {this.id,
      this.name,
      this.position,
      this.dateOfBirth,
      this.countryOfBirth,
      this.nationality,
      this.role,
      this.shirtNumber,
      this.yearsOld});

  Squad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    nationality = json['nationality'];
    role = json['role'];
    shirtNumber = json['shirtNumber'].toString();
    if (shirtNumber == "null") {
      shirtNumber = "No number";
    }
    if (dateOfBirth != null) {
      yearsOld =
          (new DateTime.now().year - int.tryParse(dateOfBirth.split("-").first))
              .toString();
    } else {
      yearsOld = "No birth info";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['dateOfBirth'] = this.dateOfBirth;
    data['countryOfBirth'] = this.countryOfBirth;
    data['nationality'] = this.nationality;
    data['role'] = this.role;
    data['shirtNumber'] = this.shirtNumber;
    return data;
  }
}
