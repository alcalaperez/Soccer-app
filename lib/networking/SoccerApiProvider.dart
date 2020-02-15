import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'CustomException.dart';

class SoccerApiProvider {
  final String _baseUrl = "https://api.football-data.org/v2/";

  Future<dynamic> get(String url) async {
    var responseJson;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Auth-Token': 'APIKEY'
    };

    try {
      final response = await http.get(_baseUrl + url, headers: requestHeaders);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}