import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/widgets/details_info.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Center(child: Text('Minsk', style: TextStyle(fontSize: 25))),
          Gap(20),
          Image.asset('assets/sun.png'),
          Gap(30),
          Text(
            '21',
            style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
          ),
          Text('Thunderstorm', style: TextStyle(fontSize: 24)),
          Text('Monday, 17 May'),
          Center(child: DetailsInfo()),
          Gap(80),
        ],
      ),
    );
  }
}
