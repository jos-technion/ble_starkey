import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEManager with ChangeNotifier {
  bool _isConnected = false;
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothDevice connectedPeripheral;
  static final _instance = BLEManager._internal();

  BLEManager._internal() {
    //init();
  }
  void startScan(callback) {
    _flutterBlue.startScan(timeout: Duration(seconds: 10));

    _flutterBlue.scanResults.listen((results) {
      // do something with scan results

      for (ScanResult r in results) {
        //TODO: call the callback with the results
      }
    });
  }

  void stopScan() {
    _flutterBlue.stopScan();
  }

  void connect(BluetoothDevice peripheral) async {
    connectedPeripheral = peripheral;

    print('connection to: ${peripheral.name}');
    // manager.stopScan();
    peripheral.state.listen((event) {
      switch (event) {
        case BluetoothDeviceState.connected:
          print('connected!');
          _isConnected = true;
          notifyListeners();
          break;
        case BluetoothDeviceState.connecting:
          print('connecting');
          break;
        case BluetoothDeviceState.disconnected:
          _isConnected = false;
          notifyListeners();

          break;
      }
      print(event);
    });
    await peripheral.connect();
  }

  void startDiscovery() async {
    List<BluetoothService> services =
        await connectedPeripheral.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == "544701c6-d711-11e4-b9d6-1681e6b88ec1") {
        print("found service");
        List<BluetoothCharacteristic> chars = service.characteristics;
        chars.forEach((char) async {
          print(char.uuid.toString());
          if (char.uuid.toString() == "544707d8-d711-11e4-b9d6-1681e6b88ec1") {
            // request char
            //TODO: make it work
            _requestChar = char;
          }
          if (char.uuid.toString() == "544706d7-d711-11e4-b9d6-1681e6b88ec1") {
            //TODO: make it work
            _imuChar = char;
          }
        });
      }
      // do something with service
    });
  }

  void disconnect() {
    _isConnected = false;
    connectedPeripheral.disconnect();
  }

  static get instance => _instance;
  bool get isConnected => _isConnected;

  //TODO: add a method to read steps
}
