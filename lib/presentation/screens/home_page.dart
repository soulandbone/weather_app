import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:weather_app/cubits/weather_cubit.dart';

import 'package:weather_app/cubits/weather_state.dart';

import 'package:weather_app/presentation/screens/settings_page.dart';
import 'package:weather_app/presentation/screens/theme_page.dart';
import 'package:weather_app/presentation/widgets/main_container.dart';
import 'package:weather_app/presentation/widgets/scrollable_row.dart';
import 'package:weather_app/presentation/widgets/switch_period.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCelsius = true;

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeatherInfo('Paris');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          PopupMenuButton(
            color: Colors.blue,
            onSelected: (value) {
              switch (value) {
                case 'Theme':
                  print('Theme has been chosen');
                  break;
                case 'Units':
                  print('Measurement units has been chosen');
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: 'Theme',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ThemePage()),
                        );
                      },
                      child: Text('Theme & Images'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Units',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                      child: Text('Units'),
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MainContainer(mainWeatherInfo: state.mainWeatherInfo),
                  Gap(10),
                  SwitchPeriod(),
                  Gap(10),

                  ScrollableRow(
                    height: 105,
                    hourbyHourDetails: state.hourByHourDetails,
                  ),
                ],
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
