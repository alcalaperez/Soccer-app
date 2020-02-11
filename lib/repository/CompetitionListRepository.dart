import 'dart:async';

import 'package:soccerapp/models/CompetitionList.dart';
import 'package:soccerapp/networking/ApiProvider.dart';

class CompetitionRepository {
  ApiProvider _provider = ApiProvider();

  Future<CompetitionList> fetchCompetitions() async {
    final response = await _provider.get("competitions?plan=TIER_ONE");
    return CompetitionList.fromJson(response);
  }
}