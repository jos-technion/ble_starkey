import 'package:ble_demo/services/ble_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectionScreen extends StatefulWidget {
  static final String id = 'connection_screen_id';
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  List<Device> devices = [];
  BLEManager manager = BLEManager.instance;

  void gotPeripheral(BluetoothDevice p) {
    //TODO: add device
    // add device to the list only if it doesn't exist
  }

  @override
  void deactivate() {
    manager.stopScan();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();

    manager.startScan(gotPeripheral);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(80),
        child: Column(
          children: [
            Text('BLE Devices: '),
            FlatButton(
              child: Text('stop scan'),
              onPressed: () {
                //TODO: stop scan
              },
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                itemBuilder: (context, idx) {
                  return ListTile(
                    title: Text(devices[idx].macAddress),
                    subtitle: devices[idx].peripheral.name == null
                        ? null
                        : Text(devices[idx].peripheral.name),
                    onTap: () async {
                      //TODO: connect to the device and return to main screen
                      return;
                    },
                  );
                },
                itemCount: devices.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Device {
  String macAddress;
  BluetoothDevice peripheral;

  Device(this.peripheral) {
    macAddress = peripheral.id.id;
  }
  bool operator ==(other) {
    return macAddress == other.macAddress;
  }

  int get hashCode {
    return macAddress.hashCode;
  }
}
