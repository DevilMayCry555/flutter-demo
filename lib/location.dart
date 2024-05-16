import 'package:location/location.dart';

import 'http.dart';

Future getLocationAsync() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  LocationData locationData;
  locationData = await location.getLocation();
  return locationData;
}

Future postLocation(String info) async {
  var res = await axios.post(
    '/open',
    data: {
      'title': 'location',
      'content': info,
      'points': 1,
      'identity': 'tydly',
      'type': 0,
    },
  );
  // print('lalala');
  return res;
}
