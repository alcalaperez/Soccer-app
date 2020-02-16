import 'package:rxdart/rxdart.dart';
import 'package:soccerapp/models/Country.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/Response.dart';
import 'package:soccerapp/repository/CountryRepository.dart';
import 'package:soccerapp/repository/SoccerRepository.dart';

class TeamBloc {
  SoccerRepository _soccerRepository;
  CountryRepository _countryRepository;

  final PublishSubject<Response<Team>> _subjectTeam =
      PublishSubject<Response<Team>>();

  TeamBloc() {
    _soccerRepository = SoccerRepository();
    _countryRepository = CountryRepository();
  }

  fetchTeam(int teamId) async {
    _subjectTeam.sink.add(Response.loading('Getting Teams.'));
    try {
      Team team = await _soccerRepository.fetchTeam(teamId);
      _subjectTeam.sink.add(Response.loading('Loading Flags.'));

      for (int i = 0; i < team.squad.length; i++) {
        _subjectTeam.sink.add(Response.loadingProgress(
            'Flag ' +
                (i + 1).toString() +
                ' of ' +
                team.squad.length.toString(),
            (i + 1) / team.squad.length));
        try {
          if (team.squad[i].nationality != null) {
            Country country = await _countryRepository.fetchCountryFlag(
                team.squad[i].nationality.split(" ").first.split("’").last);
            if (country.flag != null) {
              team.squad[i].flag = country.flag;
            }
          }
        } catch (e) {
          print(e.toString());
        }
      }
      _subjectTeam.sink.add(Response.completed(team));
    } catch (e) {
      _subjectTeam.sink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _subjectTeam.close();
  }

  PublishSubject<Response<Team>> get subject => _subjectTeam;
}
