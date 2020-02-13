import 'package:flutter/material.dart';
import 'package:soccerapp/blocs/TeamBloc.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/Response.dart';

class TeamView extends StatefulWidget {
  final int selectedTeam;
  final String teamName;

  const TeamView(this.selectedTeam, this.teamName);

  @override
  _GetShaftsState createState() => _GetShaftsState();
}

class _GetShaftsState extends State<TeamView> {
  TeamBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TeamBloc(widget.selectedTeam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Players from ' + widget.teamName,
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTeam(),
        child: StreamBuilder<Response<Team>>(
          stream: _bloc.teamListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return TeamList(team: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchTeam(),
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

class TeamList extends StatelessWidget {
  final Team team;

  const TeamList({Key key, this.team}) : super(key: key);

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
                  /*Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ShowChuckyJoke(categoryList.categories[index])));*/
                },
                child: SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            margin: EdgeInsets.all(10),
                            height: 190.0,
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage("assets/player.png"))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                                alignment: FractionalOffset.topCenter,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(team.squad[index].position??"Coach",
                                              style:
                                              new TextStyle(fontSize: 20))
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(team.squad[index].yearsOld + " years",
                                            style:
                                            new TextStyle(fontSize: 20))
                                      )
                                    ]
                                )
                            ),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(team.squad[index].shirtNumber,style:
                                    new TextStyle(fontSize: 18))
                                )
                            ),
                          ],
                        )),
                        new Text(
                          team.squad[index].name,
                          style: new TextStyle(
                              fontSize: 20.0),
                        ),
                        new Text(
                          team.squad[index].nationality,
                          style:
                              new TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
        itemCount: team.squad.length,
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
