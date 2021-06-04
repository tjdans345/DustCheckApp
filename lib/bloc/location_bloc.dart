import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc {
  final _localSubject = BehaviorSubject<LocationBloc>();

  Future<void> getPosition() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    print(currentPosition);
  }
}
