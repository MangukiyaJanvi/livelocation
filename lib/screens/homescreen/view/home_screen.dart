import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livelocation/screens/homescreen/controller/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraPosition position = CameraPosition(
      target: LatLng(21.1702, 72.8311), bearing: 0, tilt: 10, zoom: 0);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    permissionFinde();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: position,
              compassEnabled: true,
              myLocationEnabled: true,
              markers: _createMarker(homeController.let.value,homeController.lan.value),
            ),
            Positioned(
              top: 500,
              right: 20,
              child: FloatingActionButton(
                  onPressed: () async {
                    Position positione = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    homeController.lan.value = positione.longitude;
                    homeController.let.value = positione.latitude;
                  },
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.green.shade900,
                  ),
                  backgroundColor: Colors.green.shade100),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarker(double lat,double lan) {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(lat,lan),
          infoWindow: InfoWindow(title: 'Marker 1'),
          rotation: 0),
    };
  }

  Future<void> permissionFinde() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Permission.location.request();
    }
  }
}
