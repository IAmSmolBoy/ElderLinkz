import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class MqttHandler extends ValueNotifier<Map<String, String>> {

  final String serverUrl;
  final String clientIdentifier;
  final int portNumber;

  late MqttServerClient client;

  MqttHandler(super._value, {
    required this.serverUrl,
    required this.clientIdentifier,
    required this.portNumber
  }) {
    client = MqttServerClient.withPort(serverUrl, clientIdentifier, portNumber);
  }

  Future<bool?> connect() async {
    print("Connecting to $serverUrl:$portNumber with clientId of $clientIdentifier");
    client.logging(on: true);
    client.onConnected = () { print('MQTT_LOGS:: Connected'); };
    client.onDisconnected = () { print('MQTT_LOGS:: Disconnected'); };
    client.onSubscribed = (String topic) { print('MQTT_LOGS:: Subscribed topic: $topic'); };
    client.onUnsubscribed = (String? topic) { print('MQTT_LOGS:: Unsubscribed topic: $topic'); };
    client.onSubscribeFail = (String topic) { print('MQTT_LOGS:: Failed to subscribe $topic'); };
    client.pongCallback = () { print('MQTT_LOGS:: Ping response client callback invoked'); };
    client.keepAlivePeriod = 60;

    print('MQTT_LOGS::Mosquitto client connecting....');

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
      return true;
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print('MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return true;
    }

    return null;
  }

  void subscribe(String topic) {
    print('MQTT_LOGS::Subscribing to the $topic topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      super.value[topic] = pt;
      notifyListeners();
      print('MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');
    });
  }

}