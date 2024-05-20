import 'http.dart';
import 'package:geolocator/geolocator.dart';

Future postLocation() async {
  Position location = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  var res = await axios.post(
    '/open',
    data: {
      'title': 'location',
      'content': location.toString(),
      'points': 1,
      'identity': 'tydly',
      'type': 0,
    },
  );

  return res;
}
