import 'package:dustcheckapp/bloc/air_bloc.dart';
import 'package:dustcheckapp/models/air_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  AirResult? _result;

  //생명주기 -> initState 초기에 한 번 실행함
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   fetchData().then((airResult) {
  //     setState(() {
  //       _result = airResult;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamBuilder<AirResult?>(
          stream: airBloc.airResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildBody(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    ));
  }

  Padding buildBody(AirResult? _result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${airBloc.locationType} 미세먼지',
              style: TextStyle(
                  fontFamily: "ShongShong",
                  fontSize: 30,
                  color: Color(0xFF899FF3)),
            ),
            SizedBox(
              height: 16.0,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(),
                          Text('${_result!.data!.current!.pollution!.aqius!}',
                              style: TextStyle(fontSize: 30)),
                          Text(getString(_result),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      color: getColor(_result)),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://airvisual.com/images/${_result.data!.current!.weather!.ic}.png',
                              width: 32,
                              height: 32,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              '${_result.data!.current!.weather!.tp}°',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text('${_result.data!.current!.weather!.hu}%'),
                        Text('${_result.data!.current!.weather!.ws}m/s'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50),
                  primary: Color(0xffb2aadb),
                ),
                onPressed: () {
                  airBloc.fetch();
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 50),
                          primary: Color(0xffcef2fe),
                        ),
                        onPressed: () {
                          airBloc.getPosition();
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50),
                        primary: Color(0xffa7d7ff),
                      ),
                      onPressed: () {
                        airBloc.locationChange(1);
                      },
                      child: Text(
                        '부산',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50),
                        primary: Color(0xffd3e4ff),
                      ),
                      onPressed: () {
                        airBloc.locationChange(2);
                      },
                      child: Text(
                        '양산',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color? getColor(AirResult? result) {
    if (result!.data!.current!.pollution!.aqius! <= 50) {
      return Color(0xff7DF6B9);
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return Color(0xffFCFC8E);
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return Color(0xffFACDA2);
    } else {
      return Color(0xffFF9191);
    }
  }

  String getString(AirResult? result) {
    if (result!.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return '보통';
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
