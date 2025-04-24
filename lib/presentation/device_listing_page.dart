import 'package:flutter/material.dart';
import 'package:gardmei_backend_demo/data/api/endpoints/device_api.dart';
import 'package:gardmei_backend_demo/presentation/devices_page.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  final DeviceApi deviceApi = DeviceApi();
  late Future<List<String>> _deviceNamesFuture;

  @override
  void initState() {
    super.initState();
    _deviceNamesFuture = deviceApi.getAllDeviceNames();
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _deviceNamesFuture = deviceApi.getAllDeviceNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device List')),
      body: FutureBuilder<List<String>>(
        future: _deviceNamesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final deviceNames = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: _refreshDevices,
            child: ListView.builder(
              itemCount: deviceNames.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(deviceNames[index]));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DeviceScreen()),
          );
          _refreshDevices(); 
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
