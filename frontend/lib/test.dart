import 'package:elderlinkz/middleware/mqtt_handler.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late MqttHandler mqttHandler;

  @override
  void initState() {
    super.initState();

    // mqttHandler = MqttHandler({}, serverUrl: '10.0.2.2', clientIdentifier: 'frontend', portNumber: 1883);

    // mqttHandler
    //   .connect()
    //   .then((error) {
    //     if (error != true) {
    //       print("subscribing");
    //       mqttHandler.subscribe("test");
    //     }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Data received:', style: TextStyle(color: Colors.black, fontSize: 25)),
            ValueListenableBuilder<Map<String, String>>(
              builder: (BuildContext context, Map<String, String> value, Widget? child) {

                print("Changed, $value");

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('$value', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 35))
                  ],
                );
              },
              valueListenable: mqttHandler,
            )
          ],
        ),
      ),
    );
  }
}