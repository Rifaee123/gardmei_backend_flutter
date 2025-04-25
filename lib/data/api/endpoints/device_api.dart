import 'dart:convert';
import 'package:gardmei_backend_demo/data/api/api_client.dart';

class DeviceApi {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> addDevice({
    required String deviceName,
    required String model,
    required String imeiNum,
  }) async {
    final data = {"deviceName": deviceName, "model": model, "imeiNum": imeiNum};

    try {
      final response = await _apiClient.post('api/devices/add', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add device: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add device: $e');
    }
  }

  Future<List<String>> getAllDeviceNames() async {
    try {
      final response = await _apiClient.get('api/devices/getAllDeviceName');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

       
        final List<String> deviceNames =
            jsonList.map((device) => device['deviceName'].toString()).toList();

        return deviceNames;
      } else {
        throw Exception('Failed to load device names: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load device names: $e');
    }
  }
}
