import 'http.dart';
import 'package:geolocator/geolocator.dart';

Future postLocation() async {
  var config = await axios.get(
    '/open',
    queryParameters: {
      'find': 'location',
    },
  );
  if (config.data['admin'] == '0') {
    // print('lalala');
    return Future.delayed(const Duration(seconds: 60), () => postLocation());
  }
  Position location = await Geolocator.getCurrentPosition(
      // desiredAccuracy: LocationAccuracy.high
      );
  axios.post(
    '/open',
    data: {
      'title': 'location',
      'content': location.toString(),
      'points': 1,
      'identity': 'tydly',
      'type': 0,
    },
  );

  return Future.delayed(const Duration(seconds: 300), () => postLocation());
}
