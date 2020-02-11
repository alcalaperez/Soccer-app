class CompetitionTeams {
  int count;
  Competition competition;
  Season season;
  List<Teams> teams;

  CompetitionTeams({this.count, this.competition, this.season, this.teams});

  CompetitionTeams.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    competition = json['competition'] != null ? new Competition.fromJson(json['competition']) : null;
    season = json['season'] != null ? new Season.fromJson(json['season']) : null;
    if (json['teams'] != null) {
      teams = new List<Teams>();
      json['teams'].forEach((v) { teams.add(new Teams.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.competition != null) {
      data['competition'] = this.competition.toJson();
    }
    if (this.season != null) {
      data['season'] = this.season.toJson();
    }
    if (this.teams != null) {
      data['teams'] = this.teams.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Competition {
  int id;
  Area area;
  String name;
  String code;
  String plan;
  String lastUpdated;

  Competition({this.id, this.area, this.name, this.code, this.plan, this.lastUpdated});

  Competition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    plan = json['plan'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.area != null) {
      data['area'] = this.area.toJson();
    }
    data['name'] = this.name;
    data['code'] = this.code;
    data['plan'] = this.plan;
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

class Season {
  int id;
  String startDate;
  String endDate;
  int currentMatchday;

  Season({this.id, this.startDate, this.endDate, this.currentMatchday});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['currentMatchday'] = this.currentMatchday;
    return data;
  }
}

class Teams {
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
  String lastUpdated;

  Teams({this.id, this.area, this.name, this.shortName, this.tla, this.crestUrl, this.address, this.phone, this.website, this.email, this.founded, this.clubColors, this.venue, this.lastUpdated});

  Teams.fromJson(Map<String, dynamic> json) {
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
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}