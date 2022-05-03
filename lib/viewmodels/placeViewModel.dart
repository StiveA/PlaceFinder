import '../models/place.dart';

class PlaceViewModel {
  late Place _place;

  PlaceViewModel(Place place) {
    _place = place;
  }

  String get placeId {
    return this._place.placeId;
  }

  String get photoURL {
    return this._place.photoURL;
  }

  String get name {
    return this._place.name;
  }

  double get latitude {
    return this._place.latitude;
  }

  double get longitude {
    return this._place.longitude;
  }
}
