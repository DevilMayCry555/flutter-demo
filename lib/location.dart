import 'http.dart';
import 'package:geolocator/geolocator.dart';

Future postLocation() async {
  Position location = await Geolocator.getCurrentPosition(
      // desiredAccuracy: LocationAccuracy.high
      );
  var config = await axios.get(
    '/open',
    queryParameters: {
      'find': 'location',
    },
  );
  if (config.data['admin'] == '0') {
    return;
  }
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
  // print('lalala');
  return Future.delayed(const Duration(seconds: 600), () {
    // user_id
    return postLocation();
  });
}
