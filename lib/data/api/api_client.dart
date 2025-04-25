import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  final String baseUrl = 'http://localhost:5000/';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  ApiClient._internal();

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: queryParameters);
    return await http.get(uri, headers: headers);
  }

  Future<http.Response> post(String path, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$path');
    return await http.post(uri, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> put(String path, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$path');
    return await http.put(uri, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> delete(String path, {dynamic data}) async {
    final uri = Uri.parse('$baseUrl$path');
    return await http.delete(uri, headers: headers, body: jsonEncode(data));
  }
}
