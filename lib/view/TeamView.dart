import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soccerapp/blocs/TeamBloc.dart';
import 'package:soccerapp/models/Team.dart';
import 'package:soccerapp/networking/Response.dart';

class TeamView extends StatefulWidget {
  final int selectedTeam;
  final String teamName;

  const TeamView(this.selectedTeam, this.teamName);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  final bloc = TeamBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchTeam(widget.selectedTeam);
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => bloc.fetchTeam(widget.selectedTeam),
        child: StreamBuilder<Response<Team>>(
          stream: bloc.subject.stream,
          builder: (context, AsyncSnapshot<Response<Team>> snapshot) {
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
                    onRetryPressed: () => bloc.fetchTeam(widget.selectedTeam),
                  );
                  break;
                case Status.LOADING_PROGRESS:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 24),
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                          backgroundColor: Colors.white,
                          value: snapshot.data.progress,
                        ),
                      ],
                    ),
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
    bloc.dispose();
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
              child: Card(
                elevation: 5.0,
                color: Colors.white,
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        height: 200.0,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                              team.squad[index].yearsOld +
                                                  " years",
                                              style: new TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Roboto'))),
                                      if (team.squad[index].flag != null)
                                        Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SvgPicture.network(
                                              team.squad[index].flag,
                                              semanticsLabel: 'Flag',
                                              placeholderBuilder: (context) =>
                                                  Image.asset(
                                                'assets/noflag.png',
                                                width: 50,
                                              ),
                                              width: 50,
                                            ))
                                      else
                                        Image.asset(
                                          'assets/noflag.png',
                                          width: 50,
                                        ),
                                    ])),
                            Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(team.squad[index].shirtNumber,
                                        style: new TextStyle(fontSize: 22)))),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF333333),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(100, 0, 0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(team.squad[index].name,
                                  style: new TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(height: 5),
                              Text(team.squad[index].position ?? "Coach",
                                  style: new TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(height: 5),
                              Text(team.squad[index].nationality,
                                  style: new TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
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
