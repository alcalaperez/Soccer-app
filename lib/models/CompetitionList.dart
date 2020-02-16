class CompetitionList {
  int count;
  List<Competitions> competitions;

  CompetitionList({this.count, this.competitions});

  CompetitionList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['competitions'] != null) {
      competitions = new List<Competitions>();
      json['competitions'].forEach((v) {
        competitions.add(new Competitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.competitions != null) {
      data['competitions'] = this.competitions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Competitions {
  int id;
  Area area;
  String name;
  String code;
  String plan;
  CurrentSeason currentSeason;
  int numberOfAvailableSeasons;
  String lastUpdated;

  Competitions(
      {this.id,
      this.area,
      this.name,
      this.code,
      this.plan,
      this.currentSeason,
      this.numberOfAvailableSeasons,
      this.lastUpdated});

  Competitions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    plan = json['plan'];
    currentSeason = json['currentSeason'] != null
        ? new CurrentSeason.fromJson(json['currentSeason'])
        : null;
    numberOfAvailableSeasons = json['numberOfAvailableSeasons'];
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
    if (this.currentSeason != null) {
      data['currentSeason'] = this.currentSeason.toJson();
    }
    data['numberOfAvailableSeasons'] = this.numberOfAvailableSeasons;
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

class CurrentSeason {
  int id;
  String startDate;
  String endDate;
  int currentMatchday;

  CurrentSeason({this.id, this.startDate, this.endDate, this.currentMatchday});

  CurrentSeason.fromJson(Map<String, dynamic> json) {
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
