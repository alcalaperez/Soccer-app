import 'package:flutter/material.dart';

import 'Router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer App',
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigatorKey,
      initialRoute: Router.mainView,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
