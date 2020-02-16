import 'dart:async';

import 'package:soccerapp/models/CompetitionList.dart';
import 'package:soccerapp/models/CompetitionTeams.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/SoccerApiProvider.dart';

class SoccerRepository {
  SoccerApiProvider _provider = SoccerApiProvider();

  Future<CompetitionList> fetchCompetitions() async {
    final response = await _provider.get("competitions?plan=TIER_ONE");
    return CompetitionList.fromJson(response);
  }

  Future<CompetitionTeams> fetchCompetitionTeams(int competitionId) async {
    final response = await _provider
        .get("competitions/" + competitionId.toString() + "/teams");
    return CompetitionTeams.fromJson(response);
  }

  Future<Team> fetchTeam(int id) async {
    final response = await _provider.get("teams/" + id.toString());
    return Team.fromJson(response);
  }
}
