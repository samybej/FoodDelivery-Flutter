import 'dart:ffi';

import 'package:delivrili/controllers/auth_controller.dart';
import 'package:delivrili/controllers/location_controller.dart';
import 'package:delivrili/controllers/user_controller.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLoggedIn;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(45.51563, -122.677433),
    zoom: 17,
  );
  LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    _isLoggedIn = Get.find<AuthController>().userIsLoggedIn();
    if (_isLoggedIn && (Get.find<UserController>().user == null)) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address View"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      onCameraIdle: () {
                        locationController.updatePosition(
                            _cameraPosition, true);
                      },
                      onCameraMove: (position) {
                        _cameraPosition = position;
                      },
                      onMapCreated: (mapController) {
                        locationController.setMapController(mapController);
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
