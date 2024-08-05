import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final host = dotenv.env['MQTT_HOST'];

class MQTTService {
  late MqttServerClient client;
  final String broker = host ?? ''; // Địa chỉ broker của bạn
  final String clientIdentifier;

  MQTTService() : clientIdentifier = 'mqttjs_' + _randomString(8) {
    client = MqttServerClient.withPort(broker, clientIdentifier, 8000);
    client.useWebSocket = true;
    client.keepAlivePeriod = 60;
    final connMessage = MqttConnectMessage()
        .authenticateAs('username', 'password')
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
  }

  static String _randomString(int length) {
    const chars = '0123456789abcdef';
    final Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  Future<void> connect() async {
    try {
      final connMessage = MqttConnectMessage()
          .withClientIdentifier(clientIdentifier)
          .startClean();
      client.connectionMessage = connMessage;
      await client.connect();
    } catch (e) {
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  void publish(String topic, String message,
      {int qos = 0, bool retain = false}) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(
      topic,
      MqttQos.values[qos],
      builder.payload!,
      retain: retain,
    );
  }

  // Callbacks
  void onConnected() {
    print('Connected to the broker.');
  }

  void onDisconnected() {
    print('Disconnected from the broker.');
  }

  void onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed from topic: $topic');
  }

  void pong() {
    print('Ping response received.');
  }
}
