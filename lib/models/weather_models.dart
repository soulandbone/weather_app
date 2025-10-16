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

  factory MainWeatherInfo.fromJson(Map<String, dynamic> jsonData) {
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
                  time: entry['wind_dir'],
                  stringUrl:
                      entry['condition']['icon'].substring(0, 2) == '//'
                          ? 'https:${entry['condition']['icon']}'
                          : entry['condition']['icon'],
                  temperature: entry['temp_c'].toString(),
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
    required this.temperature,
  });

  final String time;
  final String stringUrl;
  final String temperature;
}
