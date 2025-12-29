import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/weather_cubit.dart';

import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/models/position_item.dart';

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
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<PositionItem> _positionItems = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  void _updatePositionList(PositionItemType type, String displayValue) {
    _positionItems.add(PositionItem(type, displayValue));
    setState(() {});
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription = serviceStatusStream
          .handleError((error) {
            _serviceStatusStreamSubscription?.cancel();
            _serviceStatusStreamSubscription = null;
          })
          .listen((serviceStatus) {
            String serviceStatusValue;
            if (serviceStatus == ServiceStatus.enabled) {
              if (positionStreamStarted) {
                _toggleListening();
              }
              serviceStatusValue = 'enabled';
            } else {
              if (_positionStreamSubscription != null) {
                setState(() {
                  _positionStreamSubscription?.cancel();
                  _positionStreamSubscription = null;
                  _updatePositionList(
                    PositionItemType.log,
                    'Position Stream has been canceled',
                  );
                });
              }
              serviceStatusValue = 'disabled';
            }
            _updatePositionList(
              PositionItemType.log,
              'Location service has been $serviceStatusValue',
            );
          });
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream
          .handleError((error) {
            _positionStreamSubscription?.cancel();
            _positionStreamSubscription = null;
          })
          .listen(
            (position) => _updatePositionList(
              PositionItemType.position,
              position.toString(),
            ),
          );
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      String statusDisplayValue;
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
        statusDisplayValue = 'resumed';
      } else {
        _positionStreamSubscription!.pause();
        statusDisplayValue = 'paused';
      }

      _updatePositionList(
        PositionItemType.log,
        'Listening for position updates $statusDisplayValue',
      );
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(PositionItemType.position, position.toString());

    print('Position is $position');
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        PositionItemType.log,
        AppStrings.kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          PositionItemType.log,
          AppStrings.kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        PositionItemType.log,
        AppStrings.kPermissionDeniedForeverMessage,
      );

      return false;
    }
    _updatePositionList(
      PositionItemType.log,
      AppStrings.kPermissionGrantedMessage,
    );

    return true;
  }

  bool isCelsius = true;

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeatherInfo('Paris');
    _toggleServiceStatusStream();
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Position Items is $_positionItems');
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
                  MainContainer(
                    onPressed: _getCurrentPosition,
                    mainWeatherInfo: state.mainWeatherInfo,
                  ),
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
