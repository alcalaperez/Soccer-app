import 'dart:async';

import 'package:soccerapp/models/CompetitionTeams.dart';
import 'package:soccerapp/networking/ApiProvider.dart';

class CompetitionTeamsRepository {
  ApiProvider _provider = ApiProvider();

  Future<CompetitionTeams> fetchCompetitionTeams(int competitionId) async {
    final response = await _provider.get("competitions/" + competitionId.toString() + "/teams");
    return CompetitionTeams.fromJson(response);
  }
}