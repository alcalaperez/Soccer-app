import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soccerapp/blocs/CompetitionTeamsBloc.dart';
import 'package:soccerapp/models/CompetitionTeams.dart';
import 'package:soccerapp/networking/Response.dart';

import '../Router.dart';

class CompetitionTeamsView extends StatefulWidget {
  final int selectedCompetition;
  final String competitionName;

  const CompetitionTeamsView(this.selectedCompetition, this.competitionName);

  @override
  _CompetitionTeamsState createState() => _CompetitionTeamsState();
}

class _CompetitionTeamsState extends State<CompetitionTeamsView> {
  final bloc = CompetitionsTeamsBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchTeams(widget.selectedCompetition);
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => bloc.fetchTeams(widget.selectedCompetition),
        child: StreamBuilder<Response<CompetitionTeams>>(
          stream: bloc.subject.stream,
          builder:
              (context, AsyncSnapshot<Response<CompetitionTeams>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CompetitionTeamsWidget(
                      competition: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        bloc.fetchTeams(widget.selectedCompetition),
                  );
                  break;
                case Status.LOADING_PROGRESS:
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
    bloc.dispose();
    super.dispose();
  }
}

class CompetitionTeamsWidget extends StatelessWidget {
  final CompetitionTeams competition;

  const CompetitionTeamsWidget({Key key, this.competition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 1.0,
            ),
            child: InkWell(
              onTap: () {
                Router.navigator.pushNamed(Router.teamView,
                    arguments: TeamViewArguments(
                      selectedTeam: competition.teams[index].id,
                        teamName: competition.teams[index].name));
              },
              child: Card(
                elevation: 3.0,
                color: Colors.white,
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(competition.teams[index].name,
                        style: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
                    SizedBox(height: 10),
                    if (competition.teams[index].crestUrl == null ||
                        competition.teams[index].crestUrl == "" ||
                        competition.teams[index].crestUrl == "null")
                      Image.asset(
                        'assets/noflag.png',
                        height: 200,
                      )
                    else if (competition.teams[index].crestUrl.endsWith('.svg'))
                      SvgPicture.network(
                        competition.teams[index].crestUrl,
                        placeholderBuilder: (context) => Image.asset(
                          'assets/noflag.png',
                          height: 200,
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                      )
                    else if (!competition.teams[index].crestUrl
                        .endsWith('.svg'))
                      CachedNetworkImage(
                        height: 200,
                        placeholder: (context, url) => Image.asset(
                          'assets/noflag.png',
                          height: 200,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/noflag.png',
                          height: 200,
                        ),
                        imageUrl: competition.teams[index].crestUrl,
                      )
                    else
                      Image.asset(
                        'assets/noflag.png',
                        height: 200,
                      ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
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
