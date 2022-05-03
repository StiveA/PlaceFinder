import 'package:finder_app/models/place.dart';

class PlaceViweModel {
  // ignore: prefer_typing_uninitialized_variables
  late final _place;

  PlaceViweModel(Place _place) {
    this._place = _place;
  }

  String get placeId {
    return _place.placeId;
  }

  String get name {
    return _place.name;
  }

  String get photoURL {
    return _place.photoURL;
  }

  double get latitude {
    return _place.latitude;
  }

  double get longetitude {
    return _place.longitude;
  }
}
