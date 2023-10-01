import 'package:earthquake/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  // late Uint8List customMarkerIcon = Uint8List(0);
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPermission();
      getCurrentLocation();
    });
    // loadCustomMarkerIcon();
  }

  // void loadCustomMarkerIcon() async {
  //   try {
  //     final ByteData byteData = await rootBundle.load('assets/images/logo.png',);
  //     customMarkerIcon = byteData.buffer.asUint8List();
  //   } catch (e) {
  //     print('Failed to load custom marker icon: $e');
  //   }
  // }

  Future<Position> getPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void goToCurrentLocation() {
    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sh * 0.5,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: Colors.grey.withOpacity(.2),
              blurRadius: 12)
        ],
      ),
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: _currentPosition,
              ),
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: Text(
                  'مكانك الحالي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
