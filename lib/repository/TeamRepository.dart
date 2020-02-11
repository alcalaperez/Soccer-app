import 'dart:async';

import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/ApiProvider.dart';

class TeamRepository {
  ApiProvider _provider = ApiProvider();

  Future<Team> fetchTeam(int id) async {
    final response = await _provider.get("teams/" + id.toString());
    return Team.fromJson(response);
  }
}