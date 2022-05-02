import 'dart:async';
import 'package:finder_app/pages/homePage.dart';
import 'package:finder_app/pages/welcomePage.dart';
import 'package:flutter/material.dart';

import 'Utils/helpers.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _permissionResult =
        PermissionHelper.checkRequiredPermissions(context);

    return MaterialApp(
      home: FutureBuilder(
        future: _permissionResult,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return WelcomePage(
            key: key,
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
