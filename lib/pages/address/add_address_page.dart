import 'dart:ffi';

import 'package:delivrili/controllers/auth_controller.dart';
import 'package:delivrili/controllers/location_controller.dart';
import 'package:delivrili/controllers/user_controller.dart';
import 'package:delivrili/models/address.dart';
import 'package:delivrili/pages/address/pick_address_map.dart';
import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_text_field.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/reusable_icons.dart';

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
      //
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          '') {
        //if the address is empty in the local storage, we take it from the server and add it.
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
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
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.user != null && _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.user?.name}';
            _contactPersonNumber.text = '${userController.user?.phone}';

            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.country ?? ''}';

              print(
                  "current address in my viewPage is ${_addressController.text}");
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15 / 3),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onTap: (latLng) {
                              Get.toNamed(Routes.getPickAddressPage(),
                                  arguments: PickAddressMapView(
                                    fromSignup: false,
                                    fromAddressPage: true,
                                    googleMapController:
                                        locationController.mapController,
                                  ));
                            },
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: (position) {
                              _cameraPosition = position;
                            },
                            onMapCreated: (mapController) {
                              locationController
                                  .setMapController(mapController);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, top: Dimensions.height20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: Dimensions.width10,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20,
                                    vertical: Dimensions.height10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15 / 3),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: Row(children: [
                                  Icon(
                                    index == 0
                                        ? Icons.home_filled
                                        : index == 1
                                            ? Icons.work
                                            : Icons.location_on,
                                    color:
                                        locationController.addressTypeIndex ==
                                                index
                                            ? AppColors.mainColor
                                            : Theme.of(context).disabledColor,
                                  )
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Delivery Address"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    ReusableTextField(
                        controller: _addressController,
                        hintText: "your address",
                        icon: Icons.map),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Contact name"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    ReusableTextField(
                        controller: _contactPersonName,
                        hintText: "name",
                        icon: Icons.person),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Phone number"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    ReusableTextField(
                        controller: _contactPersonNumber,
                        hintText: "phone number",
                        icon: Icons.phone),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        //init: MyController(),
        //initState: (_) {},
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.bottomNavigationHeight,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Address address = Address(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );

                        locationController
                            .addAddress(address)
                            .then((responseModel) {
                          if (responseModel.isSuccessful) {
                            Get.back();
                            Get.snackbar("New Address",
                                "The Address has been added successfully");

                            //The information was saved on the server
                            //Let's save the information locally
                          } else {
                            Get.snackbar("Address", "Could not save address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height15,
                            bottom: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child:
                            BigText(text: 'Save Address', color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
