import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late Set<Marker> markers = <Marker>{};
  LatLng latLng = const LatLng(24.0192811, 52.8593783);
  late CameraPosition cameraPosition;
  final Completer<GoogleMapController> _controller = Completer();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }

  getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latLng = LatLng(position.latitude, position.longitude);
    });
    cameraPosition = CameraPosition(target: latLng, zoom: 5);
    // _getXAppController.updateLocation(position.latitude, position.longitude);
    changeLocationMarker();
  }

  changeLocationMarker() {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          //add second marker
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          flat: true,
          // infoWindow: InfoWindow(//popup info
          //   title: 'person name',
          //   snippet: 'مغسلة الأمانة وعالأمانة ما هتلاقي أحسن منا',
          // ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      changeCameraLocation();
    });
  }

  changeCameraLocation() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
          target: latLng,
          // target: LatLng(_getXAppController.latLng['lat']!, _getXAppController.latLng['lng']!),
          zoom: 14,
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    cameraPosition = CameraPosition(target: latLng);
    getCurrentLocation();
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        onTap: (argument) {
          setState(() {
            latLng = argument;
            changeLocationMarker();
            // _getXAppController.updateLocation(argument.latitude, argument.longitude);
          });
        },
      ),
    );
  }
}