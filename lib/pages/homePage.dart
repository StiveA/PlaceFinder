import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../viewmodels/placeListViewModel.dart';
import '../viewmodels/placeViewModel.dart';
import '../widgets/placeList.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as prefix0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
  }

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    return places.map((place) {
      return Marker(
          markerId: MarkerId(place.placeId),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: place.name),
          position: LatLng(place.latitude, place.longitude));
    }).toSet();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 14)));
  }

  Future<void> _openMapsFor(PlaceViewModel vm) async {
    if (await MapLauncher.isMapAvailable(prefix0.MapType.google) != null) {
      await MapLauncher.showMarker(
          mapType: prefix0.MapType.google,
          zoom: 12,
          title: vm.name,
          description: vm.name,
          Coordscoords: Coords(vm.latitude, vm.longitude));
    } else if (await MapLauncher.isMapAvailable(prefix0.MapType.apple) !=
        null) {
      await MapLauncher.showMarker(
          mapType: prefix0.MapType.apple,
          zoom: 12,
          title: vm.name,
          description: vm.name,
          Coordscoords: Coords(vm.latitude, vm.longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);
    print(vm.places);

    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: vm.mapType,
          markers: _getPlaceMarkers(vm.places),
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 14),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                vm.fetchPlacesByKeywordAndPosition(value,
                    _currentPosition.latitude, _currentPosition.longitude);
              },
              decoration: const InputDecoration(
                  labelText: "Search here",
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
        ),
        Visibility(
          visible: vm.places.isNotEmpty ? true : false,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  child: const Text("Show List",
                      style: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => PlaceList(
                              places: vm.places,
                              onSelected: _openMapsFor,
                            ));
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 10,
          child: FloatingActionButton(
              onPressed: () {
                vm.toggleMapType();
              },
              child: const Icon(Icons.map)),
        )
      ]),
    );
  }
}
