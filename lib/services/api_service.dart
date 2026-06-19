import 'package:weather_app/secrets/secrets.dart';
import 'package:weather_app/services/http_client.dart';

abstract class ApiService {
  ApiService(this.httpClient);

  final HttpClient httpClient;
  Future<HttpResponse> fetchData({
    required String city,
    required String country,
    required int days,
  });
}

class ApiServiceImpl implements ApiService {
  ApiServiceImpl(this.httpClient);
  @override
  final HttpClient httpClient;

  @override
  Future<HttpResponse<String>> fetchData({
    required String city,
    required String country,
    required int days,
  }) async {
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': kApiKey,
      'days': days.toString(),
      'aqi': 'yes',
      'alerts': 'yes',
      'q': "$city,$country",
    });

    return httpClient.getRaw(url);
  }
}
