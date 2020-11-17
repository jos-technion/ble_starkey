import 'package:flutter/material.dart';
import 'services/ble_manager.dart';
import 'connection_screen.dart';

class MainScreen extends StatelessWidget {
  static final id = 'main_screen_id';
  //TODO: add a timer, and read the steps every 2.5 seconds
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('BLE Demo'),
          leading: //TODO: check whether we are connected or not
              ? Icon(Icons.bluetooth_connected)
              : Icon(Icons.bluetooth_disabled)),
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                if (//TODO: update the code ) {
                  BLEManager.instance.disconnect();
                } else {
                  Navigator.pushNamed(context, ConnectionScreen.id);
                }
              },
              child: //TODO Text should be disconnect or connect
          Padding(
            padding: const EdgeInsets.only(left: 100.0, right: 100),
            child: ListTile(
              //TODO: update class name and number of steps
              title: Text('Sitting'),
              trailing: Text('12 steps'),
            ),
          ),
        ],
      ),
    );
  }
}
