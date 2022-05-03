import 'package:finder_app/viwemodels/placeViweModel.dart';
import 'package:flutter/material.dart';

import '../services/webService.dart';

class PlaceListViweModel extends ChangeNotifier {
  var places = <PlaceViweModel>[];

  Future<void> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final results = (await Webservice()
        .fetchPlacesByKeywordAndPosition(keyword, latitude, longitude));
    places = results.map((place) => PlaceViweModel(place)).toList();

    notifyListeners();
  }
}
