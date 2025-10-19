import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<Map<String, dynamic>> getDataFromApi();
}

class ApiServiceImpl implements ApiService {
  @override
  Future<Map<String, dynamic>> getDataFromApi() async {
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': '4b73e077bfd9426f892231328250310',
      'days': '1',
      'aqi': 'yes',
      'alerts': 'yes',
      'q': 'Paris',
    });

    var response = await http.get(url);

    var data = jsonDecode(response.body);

    return data;
  }
}
