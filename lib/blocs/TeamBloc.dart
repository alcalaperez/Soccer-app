
import 'dart:async';

import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/Response.dart';
import 'package:soccerapp/repository/TeamRepository.dart';

class TeamBloc {
  TeamRepository _teamRepository;
  StreamController _teamController;

  StreamSink<Response<Team>> get teamListSink =>
      _teamController.sink;

  Stream<Response<Team>> get teamListStream =>
      _teamController.stream;

  int teamId;

  TeamBloc(int teamId) {
    _teamController = StreamController<Response<Team>>();
    _teamRepository = TeamRepository();
    this.teamId = teamId;
    fetchTeam();
  }

  fetchTeam() async {
    teamListSink.add(Response.loading('Getting Team.'));
    try {
      Team teams =
      await _teamRepository.fetchTeam(teamId);
      teamListSink.add(Response.completed(teams));
    } catch (e) {
      teamListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _teamController?.close();
  }
}