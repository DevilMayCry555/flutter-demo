import 'http.dart';
import 'package:geolocator/geolocator.dart';

Future postLocation(String identity) async {
  Position location = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  var res = await axios.post(
    '/open',
    data: {
      'title': 'location',
      'content': location.toString(),
      'points': 1,
      'identity': identity,
      'type': 0,
    },
  );

  return res;
}

Future<Position> getLocation() async {
  Position location = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return location;
}

Future clearLocation(String identity) async {
  var res =
      await axios.delete('/open', queryParameters: {'identity': identity});
  return res;
}
