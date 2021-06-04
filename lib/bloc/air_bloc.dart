import 'dart:collection';
import 'dart:convert';

import 'package:dustcheckapp/bloc/location_bloc.dart';
import 'package:dustcheckapp/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();
  String _location =
      "http://api.airvisual.com/v2/nearest_city?lat=35.17944&lon=129.07556&key=c3942c05-d8a8-4855-aea9-8b4fc506a94c";
  String locationType = "현재위치";
  int processingCheck = 0;
  double _lat = 0;
  double _lon = 0;

  AirBloc() {
    fetch();
  }

  Future<AirResult> fetchData() async {
    var uri = Uri.parse(_location);
    var response = await http.get(uri);
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  //현재위치 가져오기
  void getPosition() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    _lat = currentPosition.latitude;
    _lon = currentPosition.longitude;
    locationChange(0);
  }

  void fetch() async {
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  void locationChange(int locationType) {
    //0 : 현재 위치 , 1: 부산(default) , 2: 양산
    if (locationType == 0) {
      this._location =
          "http://api.airvisual.com/v2/nearest_city?lat=${_lat}0 &lon=${_lon}&key=c3942c05-d8a8-4855-aea9-8b4fc506a94c";
      this.locationType = "현재위치";
    } else if (locationType == 2) {
      this._location =
          "http://api.airvisual.com/v2/nearest_city?lat=35.3112800 &lon=128.9883630&key=c3942c05-d8a8-4855-aea9-8b4fc506a94c";
      this.locationType = "양산";
    } else {
      this._location =
          "http://api.airvisual.com/v2/nearest_city?lat=35.17944&lon=129.07556&key=c3942c05-d8a8-4855-aea9-8b4fc506a94c";
      this.locationType = "부산";
    }
    fetch();
  }

  Stream<AirResult>? get airResult => _airSubject.stream;
}
