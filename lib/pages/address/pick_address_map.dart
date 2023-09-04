import 'package:delivrili/controllers/location_controller.dart';
import 'package:delivrili/controllers/user_controller.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMapView extends StatefulWidget {
  final bool fromSignup; //check if we're coming from the signup page
  final bool fromAddressPage; //check if we're coming from the address page
  final GoogleMapController?
      googleMapController; //get the googleMapController instance, one instance from the entire app otherwise it would be resource heavy.

  const PickAddressMapView({
    super.key,
    required this.fromSignup,
    required this.fromAddressPage,
    required this.googleMapController,
  });

  @override
  State<PickAddressMapView> createState() => _PickAddressMapViewState();
}

class _PickAddressMapViewState extends State<PickAddressMapView> {
  late LatLng initialPosition;
  late GoogleMapController mapController;
  late CameraPosition cameraPosition;

  @override
  void initState() {
    if (Get.find<LocationController>().addressList.isEmpty) {
      initialPosition = LatLng(45.521563, -122.677433);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        );
      }
    }
    cameraPosition = CameraPosition(target: initialPosition, zoom: 17);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
              child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (newPosition) {
                      cameraPosition = newPosition;
                    },
                    onCameraIdle: () {
                      locationController.updatePosition(cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/image/pick_marker.png",
                            height: 50,
                            width: 50,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.mainBlackColor,
                          ),
                          Expanded(
                            child: Text(
                              '${locationController.pickPlacemark.name ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 200,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: CustomButton(
                      buttonText: 'address test',
                      onPressed: locationController.loading
                          ? null
                          : () {
                              //the following condition means : if the selected place exists
                              if (locationController.pickPosition.latitude !=
                                      0 &&
                                  locationController.pickPlacemark.name !=
                                      null) {
                                if (widget.fromAddressPage) {
                                  //if the googleMapController has been instanciated
                                  if (widget.googleMapController != null) {
                                    print("now you CLICKED on the button");
                                  }
                                } else {}
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
