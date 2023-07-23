import 'package:delivrili/models/address.dart';
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
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  List<Address> _addressList = [];
  List<Address> get addressList => _addressList;
  late List<Address> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;

  //this address is strictly coming from the database
  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  bool _addressIsUpdated = true;
  bool _changeAddress = true;

  late GoogleMapController _mapController;

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
}
