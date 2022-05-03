import 'package:finder_app/pages/homePage.dart';
import 'package:finder_app/viewmodels/placeListViewModel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => PlaceListViewModel(), child: HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
