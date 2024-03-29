import time
from paho.mqtt import client as mqtt_client



FIRST_RECONNECT_DELAY = 1
RECONNECT_RATE = 2
MAX_RECONNECT_COUNT = 12
MAX_RECONNECT_DELAY = 60



def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT Broker!")
    else:
        print("Failed to connect, return code %d\n", rc)

def on_disconnect(client: mqtt_client.Client, userdata, rc):
    print("Disconnected with result code: %s", rc)
    reconnect_count, reconnect_delay = 0, FIRST_RECONNECT_DELAY

    while reconnect_count < MAX_RECONNECT_COUNT:
        print("Reconnecting in %d seconds...", reconnect_delay)
        time.sleep(reconnect_delay)

        try:
            client.reconnect()
            print("Reconnected successfully!")
            return
        except Exception as err:
            print("%s. Reconnect failed. Retrying...", err)

        reconnect_delay *= RECONNECT_RATE
        reconnect_delay = min(reconnect_delay, MAX_RECONNECT_DELAY)
        reconnect_count += 1
        
    print("Reconnect failed after %s attempts. Exiting...", reconnect_count)



def connect_mqtt(BROKER: str, PORT: int, CLIENTID: str):

    client = mqtt_client.Client(CLIENTID)

    client.on_connect = on_connect
    client.on_disconnect = on_disconnect

    client.connect(BROKER, PORT)

    return client