import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  double lat, lng;
  MapPage(this.lat, this.lng, {super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    CameraPosition initLocation =
        CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 17);

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CameraPosition newLocation =
              CameraPosition(target: LatLng(30.054216, 31.337261), zoom: 15);

          final GoogleMapController myController = await _controller.future;
          myController
              .animateCamera(CameraUpdate.newCameraPosition(newLocation));
        },
        child: Icon(Icons.location_city),
      ),
    );
  }
}
