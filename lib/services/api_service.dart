import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<Map<String, dynamic>> fetchData(String city);
}

class ApiServiceImpl implements ApiService {
  @override
  Future<Map<String, dynamic>> fetchData(String city) async {
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': '4b73e077bfd9426f892231328250310',
      'days': '1',
      'aqi': 'yes',
      'alerts': 'yes',
      'q': city,
    });

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    print('data is $data');
    return data;
  }
}
