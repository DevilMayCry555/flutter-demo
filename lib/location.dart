import 'http.dart';
import 'package:geolocator/geolocator.dart';

const isProd = bool.fromEnvironment('dart.vm.product');
Future postLocation(String identity) async {
  if (isProd) {
    return Future.delayed(const Duration(seconds: 1));
  }
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
