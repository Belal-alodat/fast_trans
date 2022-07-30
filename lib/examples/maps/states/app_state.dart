import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AppState with ChangeNotifier {

  static late LatLng _initialPosition;
  late LatLng _lastPosition ;
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;

  bool locationServiceActive = true;

  Set<Marker> get markers => _markers;
  final Set<Marker> _markers = {};

  Set<Polyline> get polyLines => _polyLines;
  final Set<Polyline> _polyLines = {};



  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;


  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();


  AppState() {
    _getUserLocation();
  //  _loadingInitialPosition();
  }
// ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await  placemarkFromCoordinates(position.latitude, position.longitude);

    _initialPosition = LatLng(position.latitude, position.longitude);
    _lastPosition = _initialPosition;
    print("the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
    locationController.text = placemark.first.name ?? '';
    notifyListeners();
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }



  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition()async{
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if(_initialPosition == null){
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}
