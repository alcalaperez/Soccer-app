import 'dart:async';

import 'package:soccerapp/models/Country.dart';
import 'package:soccerapp/networking/CountriesApiProvider.dart';

class CountryRepository {
  CountriesApiProvider _provider = CountriesApiProvider();

  Future<Country> fetchCountryFlag(String country) async {
      final response = await _provider.get("name/" + country + "?fields=name;flag;");
      return Country.fromJson(response);
  }
}