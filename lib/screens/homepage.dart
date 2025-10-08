import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/models/weather_details.dart';
import 'package:weather_app/widgets/main_container.dart';
import 'package:weather_app/widgets/scrollable_row.dart';
import 'package:weather_app/widgets/switch_period.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherDetails> dailyDetails = [
    WeatherDetails(
      temperature: '13',
      time: '9pm',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9pm',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
    WeatherDetails(
      temperature: '13',
      time: '9:00',
      icon: FontAwesomeIcons.arrowLeft,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Column(
        children: [
          MainContainer(),
          SwitchPeriod(),

          ScrollableRow(height: 95, dailyDetails: dailyDetails),
        ],
      ),
    );
  }
}
