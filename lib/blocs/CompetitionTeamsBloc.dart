import 'dart:async';

import 'package:soccerapp/models/CompetitionTeams.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/Response.dart';
import 'package:soccerapp/repository/CompetitionTeamsRepository.dart';

class CompetitionsTeamsBloc {
  CompetitionTeamsRepository _competitionsTeamsRepository;
  StreamController _competitionsTeamsController;

  StreamSink<Response<CompetitionTeams>> get competitionsTeamsSink =>
      _competitionsTeamsController.sink;

  Stream<Response<CompetitionTeams>> get competitionsTeamsStream =>
      _competitionsTeamsController.stream;

  int competitionId;

  CompetitionsTeamsBloc(int competitionId) {
    _competitionsTeamsController = StreamController<Response<CompetitionTeams>>();
    _competitionsTeamsRepository = CompetitionTeamsRepository();
    this.competitionId = competitionId;
    fetchTeams();
  }

  fetchTeams() async {
    competitionsTeamsSink.add(Response.loading('Getting Team.'));
    try {
      CompetitionTeams teams =
      await _competitionsTeamsRepository.fetchCompetitionTeams(competitionId);
      competitionsTeamsSink.add(Response.completed(teams));
    } catch (e) {
      competitionsTeamsSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _competitionsTeamsController?.close();
  }
}