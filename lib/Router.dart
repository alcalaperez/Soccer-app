// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:soccerapp/view/CompetitionListView.dart';
import 'package:soccerapp/view/CompetitionTeamsView.dart';
import 'package:soccerapp/view/TeamView.dart';

class Router {
  static const mainView = '/';
  static const teamListView = '/team-list-view';
  static const teamView = '/team-view';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.mainView:
        return MaterialPageRoute(
          builder: (_) => CompetitionListView(),
          settings: settings,
        );
      case Router.teamListView:
        if (hasInvalidArgs<CompetitionTeamsViewArguments>(args)) {
          return misTypedArgsRoute<CompetitionTeamsViewArguments>(args);
        }
        final typedArgs = args as CompetitionTeamsViewArguments ??
            CompetitionTeamsViewArguments();
        return MaterialPageRoute(
          builder: (_) => CompetitionTeamsView(
              typedArgs.selectedCompetition, typedArgs.competitionName),
          settings: settings,
        );
      case Router.teamView:
        if (hasInvalidArgs<TeamViewArguments>(args)) {
          return misTypedArgsRoute<TeamViewArguments>(args);
        }
        final typedArgs = args as TeamViewArguments ?? TeamViewArguments();
        return MaterialPageRoute(
          builder: (_) => TeamView(typedArgs.selectedTeam, typedArgs.teamName),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//CompetitionTeamsView arguments holder class
class CompetitionTeamsViewArguments {
  final int selectedCompetition;
  final String competitionName;
  CompetitionTeamsViewArguments(
      {this.selectedCompetition, this.competitionName});
}

//TeamView arguments holder class
class TeamViewArguments {
  final int selectedTeam;
  final String teamName;
  TeamViewArguments({this.selectedTeam, this.teamName});
}
