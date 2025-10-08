import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_details.dart';
import 'package:weather_app/widgets/oval_button.dart';

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({
    required this.height,
    required this.dailyDetails,
    super.key,
  });

  final List<WeatherDetails> dailyDetails;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyDetails.length,
        itemBuilder:
            (context, index) => OvalButton(
              temperature: dailyDetails[index].temperature,
              icon: dailyDetails[index].icon,
              time: dailyDetails[index].time,
            ),
      ),
    );
  }
}
