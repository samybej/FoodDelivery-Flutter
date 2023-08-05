import 'dart:convert';

import 'package:delivrili/models/address.dart';
import 'package:delivrili/models/response.dart';
import 'package:delivrili/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  Position get position => _position;
  late Position _pickPosition;
  Position get pickPosition => _pickPosition;
  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<Address> _addressList = [];
  List<Address> get addressList => _addressList;
  late List<Address> _allAddressList;
  List<Address> get allAddressList => _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  //this address is strictly coming from the database
  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  bool _addressIsUpdated = true;
  bool _changeAddress = true;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  //setter for _mapController
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_addressIsUpdated) {
      _loading = true;
      update();

      try {
        if (fromAddress) {
          _position = Position(
              latitude: cameraPosition.target.latitude,
              longitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        } else {
          _pickPosition = Position(
              latitude: cameraPosition.target.latitude,
              longitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String address = "Unknown location";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body["status"] == "OK") {
      address = response.body["results"][0]['formatted_address'].toString();
      print("printing address : " + address);
    } else {
      print("Error getting the google maps api");
    }
    return address;
  }

  Address getUserAddress() {
    late Address address;

    _getAddress = jsonDecode(
        locationRepo.getUserAddress()); //parses a String into a Json object

    try {
      address = Address.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    return address;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(Address address) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(address);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      print("address Added successfully");
      responseModel = ResponseModel(true, response.body["message"]);
      await saveUserAddress(address);
    } else {
      print("could not save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddresses();
    _addressList = [];
    _allAddressList = [];
    if (response.statusCode == 200) {
      response.body.forEach((address) {
        _addressList.add(Address.fromJson(address));
        _allAddressList.add(Address.fromJson(address));
      });
    }
    update();
  }

  Future<bool> saveUserAddress(Address address) async {
    String userAddress = jsonEncode(
        address.toJson()); //it will encode the Map<> object to a json string

    return await locationRepo.saveUserAddress(userAddress);
  }
}
