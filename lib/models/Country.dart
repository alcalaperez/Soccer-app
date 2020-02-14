class Country {
  String name;
  String flag;

  Country(
      {this.name,
        this.flag});

  Country.fromJson(List<dynamic> json) {
    name = json.first['name'];
    flag = json.first['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['flag'] = this.flag;
    return data;
  }
}
