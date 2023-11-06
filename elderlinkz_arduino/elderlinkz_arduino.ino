#include <WiFi.h>
#include <PubSubClient.h>

// DHT dht_sensor(23, DHT22);
const char *ssid = "TP-LINK_6F62";         // Please enter the wifi name
const char *password = "12345678";        // Please enter the wifi password
const char *mqtt_broker = "192.168.0.10"; // this is the IP where Mosquitto MQTT is running (home is 192.168.0.182),(phone is 192.168.43.36)(AVEVA 192.168.4.113)currently connect to phone*/
const char *topic = "temperature";
const char *mqtt_user = "";
const char *mqtt_password = "";
const int mqtt_port = 1883; /* have to verify the correct mqtt port number so that they can communicate */

int counter = 0;
char cstr[10];
char cstr1[10];
char cstr2[10];
char cstr3[10];
char cstr4[10];
char cstr5[10];

WiFiClient espClient;
PubSubClient client(espClient);

float floatMap(float x, float in_min, float in_max, float out_min, float out_max) => (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  if ()
  Serial.println("Connected to the WiFi network.");
  client.setServer(mqtt_broker, mqtt_port);
}

void loop() {
  // put your main code here, to run repeatedly:

}
