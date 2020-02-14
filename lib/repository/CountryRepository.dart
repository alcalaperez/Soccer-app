import 'dart:async';

import 'package:soccerapp/models/Country.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/CountriesApiProvider.dart';
import 'package:soccerapp/networking/SoccerApiProvider.dart';

class CountryRepository {
  CountiesApiProvider _provider = CountiesApiProvider();

  Future<Country> fetchCountryFlag(String country) async {
    try {
      final response = await _provider.get("name/" + country + "?fields=name;flag;");
       return Country.fromJson(response);
    } catch(e) {
      print(e);
    }
  }
}