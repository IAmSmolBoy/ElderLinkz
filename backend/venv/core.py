import os
from dotenv import load_dotenv
from paho.mqtt.client import MQTTMessage

from connections.mqtt import connect_mqtt
from connections.sql import connect_sql

load_dotenv()





# MQTT variables
BROKER = os.getenv('BROKER') # broker uri or ip
PORT = int(os.getenv('PORT')) # port no.
CLIENTID = os.getenv('CLIENTID') # unique clientId
TOPIC = "test"

# SQL variables
CONNECTION_STR = (
    f"{os.getenv('SQL_DRIVER')}"
    f"{os.getenv('SQL_SERVER')}"
    f"{os.getenv('SQL_DB')}"
    f"{os.getenv('SQL_AUTH')}"
) # connection string for sql driver






if __name__ == '__main__':
    client = connect_mqtt(BROKER, PORT, CLIENTID)
    sqlConnection = connect_sql(CONNECTION_STR)
    sql = sqlConnection.cursor()

    def on_message(client, userdata, msg: MQTTMessage):
        sql.execute(f"INSERT INTO testTable (testCol) VALUES ({msg.payload.decode()});")
        sqlConnection.commit()

        print(f"Payload: {msg.payload.decode()}, Topic: {msg.topic}")

    client.on_message = on_message
    client.subscribe(TOPIC)
    
    client.loop_forever()