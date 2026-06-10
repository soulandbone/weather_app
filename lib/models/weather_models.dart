import 'package:weather_app/helpers/date_formatter.dart';

class MainWeatherInfo {
  MainWeatherInfo({
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
    required this.locationCity,
    required this.locationCountry,
    required this.windSpeedKm,
    required this.windSpeedMi,
    required this.humidity,
    required this.rainChance,
    required this.condition,
    required this.imageUrl,
  });

  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final String locationCity;
  final String locationCountry;
  final double windSpeedKm;
  final double windSpeedMi;
  final int humidity;
  final int rainChance;
  final String condition;
  final String imageUrl;

  factory MainWeatherInfo.fromJson(Map<String, dynamic> jsonData) {
    return MainWeatherInfo(
      temperatureCelsius: (jsonData['current']['temp_c'] as num).toDouble(),
      temperatureFahrenheit: (jsonData['current']['temp_f'] as num).toDouble(),
      locationCity: jsonData['location']['name'],
      locationCountry: jsonData['location']['country'],
      condition: jsonData['current']['condition']['text'],
      windSpeedKm: (jsonData['current']['wind_kph'] as num).toDouble(),
      windSpeedMi: (jsonData['current']['wind_mph'] as num).toDouble(),
      humidity: (jsonData['current']['humidity'] as num).toInt(),
      rainChance:
          (jsonData['forecast']['forecastday'][0]['day']['daily_chance_of_rain']
                  as num)
              .toInt(),
      imageUrl:
          jsonData['current']['condition']['icon'].substring(0, 2) == '//'
              ? 'https:${jsonData['current']['condition']['icon']}'
              : jsonData['current']['condition']['icon'],
    );
  }
}

class HourByHourDetails {
  // this to encapsulate all the possible hours of the day
  HourByHourDetails({required this.hourlyData});

  final List<HourlyWeatherDetails> hourlyData; //refine the data type

  factory HourByHourDetails.fromJson(Map<String, dynamic> jsonData) {
    return HourByHourDetails(
      hourlyData:
          jsonData['forecast']['forecastday'][0]['hour']
              .map<HourlyWeatherDetails>(
                (entry) => HourlyWeatherDetails.fromJson(entry),
              )
              .toList(),
    );
  }
}

class HourlyWeatherDetails {
  // this class just takes control of what happens in ONE hour
  HourlyWeatherDetails({
    required this.time,
    required this.stringUrl,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
  });

  final String time;
  final String stringUrl;
  final double temperatureCelsius;
  final double temperatureFahrenheit;

  factory HourlyWeatherDetails.fromJson(Map<String, dynamic> json) {
    //this is partial json, not the whole jsonData object, because it starts from jsonData['forecast']['forecastday'][0]['hour']
    final time = DateFormatter().getRegularTime(json['time']);
    final stringUrl =
        json['condition']['icon'].substring(0, 2) == '//'
            ? 'https:${json['condition']['icon']}'
            : json['condition']['icon'];
    final temperatureCelsius = (json['temp_c'] as num).toDouble();
    final temperatureFahrenheit = (json['temp_f'] as num).toDouble();

    return HourlyWeatherDetails(
      time: time,
      stringUrl: stringUrl,
      temperatureCelsius: temperatureCelsius,
      temperatureFahrenheit: temperatureFahrenheit,
    );
  }
}

class WeatherResponse {
  WeatherResponse({
    required this.mainWeatherInfo,
    required this.hourByHourDetails,
  });
  final MainWeatherInfo mainWeatherInfo;
  final HourByHourDetails hourByHourDetails;

  factory WeatherResponse.fromJson(Map<String, dynamic> jsonData) {
    var mainWeatherData = MainWeatherInfo.fromJson(jsonData);
    var hourByHourDetailsData = HourByHourDetails.fromJson(jsonData);

    return WeatherResponse(
      mainWeatherInfo: mainWeatherData,
      hourByHourDetails: hourByHourDetailsData,
    );
  }
}

class ThreeDaysForecast {
  ThreeDaysForecast(this.forecastDays);

  final List<DailyForecast> forecastDays;

  factory ThreeDaysForecast.fromJson(Map<String, dynamic> jsonData) {
    final listOfDays =
        jsonData['forecast']['forecastday'] as List; //list of days

    final listOfThreeDays = listOfDays.take(3);

    final result =
        listOfThreeDays
            .map<DailyForecast>((e) => DailyForecast.fromJson(e))
            .toList();

    return ThreeDaysForecast(result);
  }
}

class DailyForecast {
  DailyForecast({
    required this.maxTempF,
    required this.maxTempC,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.condition,
    required this.stringUrl,
  });

  final double maxTempF;
  final double maxTempC;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;
  final String condition;
  final String stringUrl;

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    final maxTempF = json['day']['maxtemp_f'];
    final maxTempC = json['day']['maxtemp_c'];
    final minTempC = json['day']['mintemp_c'];
    final minTempF = json['day']['mintemp_f'];
    final avgTempC = json['day']['avgtemp_c'];
    final avgTempF = json['day']['avgtemp_f'];
    final condition = json['day']['condition']['text'];

    final stringUrl =
        json['day']['condition']['icon'].substring(0, 2) == '//'
            ? 'https:${json['day']['condition']['icon']}'
            : json['day']['condition']['icon'];

    return DailyForecast(
      maxTempF: maxTempF,
      maxTempC: maxTempC,
      minTempC: minTempC,
      minTempF: minTempF,
      avgTempC: avgTempC,
      avgTempF: avgTempF,
      condition: condition,
      stringUrl: stringUrl,
    );
  }
}
