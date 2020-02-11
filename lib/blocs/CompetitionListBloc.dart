
import 'dart:async';

import 'package:soccerapp/models/CompetitionList.dart';
import 'package:soccerapp/networking/Response.dart';
import 'package:soccerapp/repository/CompetitionListRepository.dart';

class CompetitionListBloc {
  CompetitionRepository _competitionRepository;
  StreamController _competitionsController;

  StreamSink<Response<CompetitionList>> get competitionsListSink =>
      _competitionsController.sink;

  Stream<Response<CompetitionList>> get competitionsListStream =>
      _competitionsController.stream;

  CompetitionListBloc() {
    _competitionsController = StreamController<Response<CompetitionList>>();
    _competitionRepository = CompetitionRepository();
    fetchCompetition();
  }

  fetchCompetition() async {
    competitionsListSink.add(Response.loading('Getting competitions.'));
    try {
      CompetitionList competition =
      await _competitionRepository.fetchCompetitions();
      //competition.competitions.removeWhere((value) => !availableCompetitionsForFree.contains(value.id));
      competitionsListSink.add(Response.completed(competition));
    } catch (e) {
      competitionsListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _competitionsController?.close();
  }
}