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

  final String temperatureCelsius;
  final String temperatureFahrenheit;
  final String locationCity;
  final String locationCountry;
  final String windSpeedKm;
  final String windSpeedMi;
  final String humidity;
  final String rainChance;
  final String condition;
  final String imageUrl;

  factory MainWeatherInfo.fromJson(Map<String, dynamic> jsonData) {
    print(
      "Country and city are ${jsonData['location']['country']} ${jsonData['location']['name']}",
    );

    return MainWeatherInfo(
      temperatureCelsius: jsonData['current']['temp_c'].toString(),
      temperatureFahrenheit: jsonData['current']['temp_f'].toString(),
      locationCity: jsonData['location']['name'],
      locationCountry: jsonData['location']['country'],
      condition: jsonData['current']['condition']['text'],
      windSpeedKm: jsonData['current']['wind_kph'].toString(),
      windSpeedMi: jsonData['current']['wind_mph'].toString(),
      humidity: jsonData['current']['humidity'].toString(),
      rainChance:
          jsonData['forecast']['forecastday'][0]['day']['daily_chance_of_rain']
              .toString(),
      imageUrl:
          jsonData['current']['condition']['icon'].substring(0, 2) == '//'
              ? 'https:${jsonData['current']['condition']['icon']}'
              : jsonData['current']['condition']['icon'],
    );
  }
}

class HourbyHourDetails {
  // this to encapsulate all the possible hours of the day
  HourbyHourDetails({required this.hourlyData});

  final List<dynamic> hourlyData; //refine the data type

  factory HourbyHourDetails.fromJson(Map<String, dynamic> jsonData) {
    return HourbyHourDetails(
      hourlyData:
          (jsonData['forecast']['forecastday'][0]['hour'])
              .map(
                (entry) => HourlyWeatherDetails(
                  time: DateFormatter().getRegularTime(entry['time']),
                  stringUrl:
                      entry['condition']['icon'].substring(0, 2) == '//'
                          ? 'https:${entry['condition']['icon']}'
                          : entry['condition']['icon'],
                  temperatureCelsius: entry['temp_c'].toString(),
                  temperatureFahrenheit: entry['temp_f'].toString(),
                ),
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
  final String temperatureCelsius;
  final String temperatureFahrenheit;
}
