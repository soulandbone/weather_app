import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/secrets/secrets.dart';

abstract class ApiService {
  Future<Map<String, dynamic>> fetchData(
    String city,
    String country, {
    int days = 1,
  });
}

class ApiServiceImpl implements ApiService {
  @override
  Future<Map<String, dynamic>> fetchData(
    String city,
    String country, {
    int days = 1,
  }) async {
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': kApiKey,
      'days': days.toString(),
      'aqi': 'yes',
      'alerts': 'yes',
      'q': "$city,$country",
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }
  }
}
