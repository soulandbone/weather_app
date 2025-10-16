import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/widgets/main_container.dart';
import 'package:weather_app/widgets/scrollable_row.dart';
import 'package:weather_app/widgets/switch_period.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _dataFetched;
  bool isCelsius = true;

  @override
  void initState() {
    super.initState();

    _dataFetched = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': '4b73e077bfd9426f892231328250310',
      'days': '1',
      'aqi': 'yes',
      'alerts': 'yes',
      'q': 'Paris',
    });

    var response = await http.get(url);

    var data = jsonDecode(response.body);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: FutureBuilder(
        future: _dataFetched,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            MainWeatherInfo mainWeatherInfo = MainWeatherInfo.fromJson(
              snapshot.data!,
            );

            HourbyHourDetails hourbyHourDetails = HourbyHourDetails.fromJson(
              snapshot.data!,
            );
            //print(snapshot.data!['forecast']['forecastday'][0]['hour']);
            return SingleChildScrollView(
              child: Column(
                children: [
                  MainContainer(mainWeatherInfo: mainWeatherInfo),
                  Gap(10),
                  SwitchPeriod(),
                  Gap(10),

                  ScrollableRow(
                    height: 105,
                    hourbyHourDetails: hourbyHourDetails,
                  ),
                ],
              ),
            );
          }
          return Center(child: Container());
        },
      ),
    );
  }
}
