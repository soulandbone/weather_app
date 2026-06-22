import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_strings.dart';
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

enum HomeMenuItem { theme, units }

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
        title: const Text(AppStrings.kAppName),
        actions: [
          PopupMenuButton<HomeMenuItem>(
            color: Colors.blue,
            onSelected: (HomeMenuItem value) {
              switch (value) {
                case HomeMenuItem.theme:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ThemePage()),
                  );
                  break;
                case HomeMenuItem.units:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: HomeMenuItem.theme,

                    child: Text(
                      AppStrings.kTheme,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  PopupMenuItem(
                    value: HomeMenuItem.units,
                    child: Text(
                      AppStrings.kUnits,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
                        ? _hourlyWeatherDetails(state, isCelsius)
                        : state.isForecastLoading
                        ? Center(child: CircularProgressIndicator())
                        : _dailyWeatherDetails(state, isCelsius),
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

Widget _hourlyWeatherDetails(WeatherLoaded state, bool isCelsius) {
  return ScrollableRow<HourlyWeatherDetails>(
    height: 125,
    details: state.weatherResponse.hourByHourDetails.hourlyData,

    itemBuilder: (context, index, isSelected, onSelection) {
      return HourlyContainer(
        hourlyWeatherDetails:
            state.weatherResponse.hourByHourDetails.hourlyData[index],
        isSelected: isSelected,
        onSelection: onSelection,
        isCelsius: isCelsius,
      );
    },
  );
}

Widget _dailyWeatherDetails(WeatherLoaded state, bool isCelsius) {
  return ScrollableRow<DailyForecast>(
    height: 125,
    details: state.forecastResponse!.forecastDays,

    itemBuilder: (context, index, isSelected, onSelection) {
      return DailyContainer(
        width: 130,
        forecast: state.forecastResponse!.forecastDays[index],
        isCelsius: isCelsius,
        isSelected: isSelected,
        onSelection: onSelection,
      );
    },
  );
}
