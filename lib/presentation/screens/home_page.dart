import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_settings_state.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/presentation/screens/settings_page.dart';
import 'package:weather_app/presentation/screens/theme_page.dart';
import 'package:weather_app/presentation/widgets/daily_container.dart';
import 'package:weather_app/presentation/widgets/hourly_container.dart';
import 'package:weather_app/presentation/widgets/main_container.dart';
import 'package:weather_app/presentation/widgets/scrollable_row.dart';
import 'package:weather_app/presentation/widgets/switch_period.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOneDay = true;

  @override
  void initState() {
    super.initState();

    context.read<WeatherCubit>().fetchLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    final isCelsius = context.select<AppSettingsCubit, bool>((cubit) {
      final currentState = cubit.state;
      if (currentState is SettingsLoaded) {
        return currentState.temperature == TemperatureUnits.celsius;
      } else {
        return true;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          PopupMenuButton(
            onOpened: () {},
            color: Colors.blue,
            onSelected: (value) {
              switch (value) {
                case 'Theme':
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => ThemePage()));
                  break;
                case 'Units':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 'Theme', child: Text('Theme & Images')),
                  PopupMenuItem(value: 'Units', child: Text('Units')),
                ],
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return RefreshIndicator(
              key: ValueKey("refresh"),
              onRefresh: () {
                return context.read<WeatherCubit>().fetchLocationAndWeather();
              },

              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    MainContainer(
                      mainWeatherInfo: state.weatherResponse.mainWeatherInfo,
                      isCelsius: isCelsius,
                    ),
                    const Gap(10),

                    SwitchPeriod(
                      onChanged: (value) {
                        setState(() {
                          isOneDay = value;
                        });
                      },
                    ),
                    const Gap(10),
                    isOneDay
                        ? ScrollableRow<HourlyWeatherDetails>(
                          height: 125,
                          details:
                              state
                                  .weatherResponse
                                  .hourByHourDetails
                                  .hourlyData,

                          itemBuilder: (
                            context,
                            index,
                            isSelected,
                            onSelection,
                          ) {
                            return HourlyContainer(
                              hourlyWeatherDetails:
                                  state
                                      .weatherResponse
                                      .hourByHourDetails
                                      .hourlyData[index],
                              isSelected: isSelected,
                              onSelection: onSelection,
                              isCelsius: isCelsius,
                            );
                          },
                        )
                        : state.isForecastLoading
                        ? Center(child: CircularProgressIndicator())
                        : ScrollableRow<DailyForecast>(
                          height: 125,
                          details: state.forecastResponse!.forecastDays,

                          itemBuilder: (
                            context,
                            index,
                            isSelected,
                            onSelection,
                          ) {
                            return DailyContainer(
                              width: 130,
                              forecast:
                                  state.forecastResponse!.forecastDays[index],
                              isCelsius: isCelsius,
                              isSelected: isSelected,
                              onSelection: onSelection,
                            );
                          },
                        ),
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherCubit>().fetchLocationAndWeather();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
