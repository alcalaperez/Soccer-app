import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soccerapp/blocs/CompetitionTeamsBloc.dart';
import 'package:soccerapp/models/CompetitionTeams.dart';
import 'package:soccerapp/networking/Response.dart';

import 'TeamView.dart';

class CompetitionTeamsView extends StatefulWidget {
  final int selectedCompetition;
  final String competitionName;

  const CompetitionTeamsView(this.selectedCompetition, this.competitionName);

  @override
  _GetShaftsState createState() => _GetShaftsState();
}

class _GetShaftsState extends State<CompetitionTeamsView> {
  CompetitionsTeamsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CompetitionsTeamsBloc(widget.selectedCompetition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Teams from ' + widget.competitionName,
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTeams(),
        child: StreamBuilder<Response<CompetitionTeams>>(
          stream: _bloc.competitionsTeamsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CompetitionTeamsWidget(competition: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchTeams(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CompetitionTeamsWidget extends StatelessWidget {
  final CompetitionTeams competition;

  const CompetitionTeamsWidget({Key key, this.competition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TeamView(competition.teams[index].id, competition.teams[index].name)));
                  },
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      color: Color(0xFF333333),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                          SvgPicture.network(
                        competition.teams[index].crestUrl,
                          placeholderBuilder: (context) => Icon(Icons.error_outline),
                          height: 48.0, width: 48.0,
                        ), SizedBox(width: 50),
                        Text(
                          competition.teams[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        )],
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: competition.teams.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}