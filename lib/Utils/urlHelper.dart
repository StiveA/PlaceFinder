class UrlHelper {
  static String urlForReferenceImage(String photoReferenceId) {
    return ("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReferenceId&key=AIzaSyDhCn-6GFiJTz-OcLhR2-2YjJra3jsx-dA");
  }

  static Uri urlForPlaceKeywordAndLocation(
      String keyword, double latitude, double longitude) {
    return Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=restaurant&keyword=$keyword&key=AIzaSyDhCn-6GFiJTz-OcLhR2-2YjJra3jsx-dA");
  }
}
