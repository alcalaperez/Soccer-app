import 'package:rxdart/rxdart.dart';
import 'package:soccerapp/models/CompetitionList.dart';
import 'package:soccerapp/networking/Response.dart';
import 'package:soccerapp/repository/SoccerRepository.dart';

class CompetitionListBloc {
  SoccerRepository _soccerRepository;

  final PublishSubject<Response<CompetitionList>> _subject =
      PublishSubject<Response<CompetitionList>>();

  CompetitionListBloc() {
    _soccerRepository = SoccerRepository();
  }

  fetchCompetition() async {
    _subject.sink.add(Response.loading('Getting Competitions.'));
    try {
      CompetitionList competitions =
          await _soccerRepository.fetchCompetitions();
      _subject.sink.add(Response.completed(competitions));
    } catch (e) {
      _subject.sink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _subject.close();
  }

  PublishSubject<Response<CompetitionList>> get subject => _subject;
}

final bloc = CompetitionListBloc();
