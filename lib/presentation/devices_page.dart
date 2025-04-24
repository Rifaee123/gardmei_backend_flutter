import 'package:flutter/material.dart';
import 'package:gardmei_backend_demo/data/api/endpoints/device_api.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final DeviceApi deviceApi = DeviceApi();

  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _imeiController = TextEditingController();

  void _submitDevice() async {
    final deviceName = _deviceNameController.text.trim();
    final model = _modelController.text.trim();
    final imeiNum = _imeiController.text.trim();

    if (deviceName.isEmpty || model.isEmpty || imeiNum.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final response = await deviceApi.addDevice(
        deviceName: deviceName,
        model: model,
        imeiNum: imeiNum,
      );

      print('Device added: $response');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Success: ${response['deviceName']}')),
      );

      _deviceNameController.clear();
      _modelController.clear();
      _imeiController.clear();
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deviceNameController,
              decoration: const InputDecoration(labelText: 'Device Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _modelController,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imeiController,
              decoration: const InputDecoration(labelText: 'IMEI Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitDevice,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
