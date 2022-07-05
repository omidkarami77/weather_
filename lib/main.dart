import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:weather/model/current_city_data_model.dart';
import 'package:weather/model/forecast_days_model.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<CurrentCityDataModel>? currentWeatherFeature;
  StreamController<List<ForeCastDaysModel>>? steamForeCastDays;
  var cityName = 'texas';
  var lat;
  var long;
  var apikey = '789356c0c7a94435f532420a154aa33c';

  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    currentWeatherFeature = SendRequestCurrentWeather(cityName);
    steamForeCastDays = StreamController<List<ForeCastDaysModel>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return {'Setting', 'logout'}.map((String Choice) {
              return PopupMenuItem(child: Text(Choice), value: Choice);
            }).toList();
          }),
        ],
      ),
      body: FutureBuilder<CurrentCityDataModel>(
          future: currentWeatherFeature,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CurrentCityDataModel cityDataModel = snapshot.data!;

              final formatter = DateFormat.jm();
              var sunrise = formatter.format(
                  new DateTime.fromMillisecondsSinceEpoch(
                      cityDataModel!.sunrise * 1000,
                      isUtc: true));
              var sunset = formatter.format(
                  new DateTime.fromMillisecondsSinceEpoch(
                      cityDataModel.sunset * 1000,
                      isUtc: true));

              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/pic_bg.jpg"),
                  fit: BoxFit.cover,
                )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("find"),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Enter a city name '),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            cityDataModel.cityName.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            cityDataModel.decription.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Icon(
                            Icons.wb_sunny_outlined,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            cityDataModel.temp.toString() + "\u00b0",
                            style: TextStyle(color: Colors.white, fontSize: 60),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "max",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    cityDataModel.temp_max.toString() +
                                        "\u00b0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                width: 1,
                                height: 40,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "min",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    cityDataModel.temp_min.toString() +
                                        "\u00b0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: ListView.builder(
                                itemCount: 6,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return Container(
                                    height: 60,
                                    width: 70,
                                    child: Card(
                                      color: Colors.transparent,
                                      child: Column(children: [
                                        Text(
                                          "fri ,8pm",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Expanded(
                                            child:
                                                setIconForMain(cityDataModel)),
                                        Text(
                                          "14",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ]),
                                      elevation: 0,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "wind speed",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    cityDataModel.windSpeed.toString() + " m/s",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              child: Container(
                                color: Colors.white,
                                height: 40,
                                width: 1,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "sunrise",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    sunrise,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              child: Container(
                                color: Colors.white,
                                height: 40,
                                width: 1,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "sunset",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    sunset,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              child: Container(
                                color: Colors.white,
                                height: 40,
                                width: 1,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "humidity",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    cityDataModel.humidity.toString() + " %",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: JumpingDotsProgressIndicator(
                  color: Colors.black,
                  fontSize: 60,
                  dotSpacing: 2,
                ),
              );
            }
          }),
    );
  }

  Image setIconForMain(CurrentCityDataModel model) {
    String description = model.decription!;
    if (description == "clear sky") {
      return Image(
          image: AssetImage(
        'images/icons8-sun-96.png',
      ));
    } else if (description == "few clouds") {
      return Image(image: AssetImage('images/icons8-partly-cloudy-day-80.png'));
    } else if (description.contains("clouds")) {
      return Image(image: AssetImage('images/icons8-clouds-80.png'));
    } else if (description.contains("thunderstorm")) {
      return Image(image: AssetImage('images/icons8-storm-80.png'));
    } else if (description.contains("drizzle")) {
      return Image(image: AssetImage('images/icons8-rain-cloud-80.png'));
    } else if (description.contains("rain")) {
      return Image(image: AssetImage('images/icons8-heavy-rain-80.png'));
    } else if (description.contains("snow")) {
      return Image(image: AssetImage('images/icons8-snow-80.png'));
    } else {
      return Image(image: AssetImage('images/icons8-windy-weather-80.png'));
    }
  }

  Future<CurrentCityDataModel> SendRequestCurrentWeather(var citiName) async {
    var response = await Dio().get(
        'http://api.openweathermap.org/data/2.5/weather',
        queryParameters: {"q": cityName, "appid": apikey, "units": "metric"});

    print(response.data);
    print(response.statusCode);

    lat = response.data['coord']['lat'];
    long = response.data['coord']['long'];
    var dataModel = CurrentCityDataModel(
        response.data['name'],
        response.data['weather'][0]['main'],
        response.data['coord']['long'],
        response.data['coord']['lat'],
        response.data['weather'][0]['description'],
        response.data['main']['temp'],
        response.data['main']['temp_max'],
        response.data['main']['temp_min'],
        response.data['main']['pressure'],
        response.data['main']['humidity'],
        response.data['wind']['speed'],
        response.data['dt'],
        response.data['sys']['country'],
        response.data['sys']['sunrise'],
        response.data['sys']['sunset']);

    return dataModel;
  }

  void SendRequest7DaysForeCast(lat, long) async {
    List<ForeCastDaysModel> list = [];

    try {
      var response = await Dio().get(
          "https://api.openweathermap.org/data/2.5/onecall",
          queryParameters: {
            'lat': lat,
            'long': long,
            'exlude': 'minutely,hourly',
            'appid': apikey,
            'units': 'metric'
          });

      final formatter = DateFormat.MMMd();

      for (var i = 0; i < 8; i++) {
        var model = response.data['daily'][i];
        var dt = formatter.format(new DateTime.fromMillisecondsSinceEpoch(
            model['dt'] = 1000,
            isUtc: true));

        ForeCastDaysModel foreCastDaysModel = ForeCastDaysModel(
            dt,
            model['temp']['day'],
            model['weather'][0]['main'],
            model['weather'][0]['description']);

        list.add(foreCastDaysModel);
      }

      steamForeCastDays!.add(list);
    } on DioError catch (e) {
      print(e.response!.statusCode);
      print(e.message);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("there is an")));
    }
  }
}
