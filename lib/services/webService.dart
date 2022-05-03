import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Utils/urlHelper.dart';
import '../models/place.dart';

class Webservice {
  Future<List<Place>> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final url =
        UrlHelper.urlForPlaceKeywordAndLocation(keyword, latitude, longitude);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Iterable results = jsonResponse["results"];
      return results.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
