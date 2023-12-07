import os
from dotenv import load_dotenv
from paho.mqtt.client import MQTTMessage
from requests import get, post

from connections.mqtt import connect_mqtt
from connections.sql import connect_sql
from connections.opcua_client import connect_opcua
from connections.http import Http

load_dotenv()





TOPICS = [
    "temperature",
    "gsr",
    "oxygen",
    "heart"
] # simulation topics (If you have more values add here)

# MQTT variables
BROKER = os.getenv('BROKER') # broker uri or ip
PORT = int(os.getenv('PORT')) # port no.
CLIENTID = os.getenv('CLIENTID') # unique clientId

# SQL variables
CONNECTION_STR = (
    f"Driver={os.getenv('SQL_DRIVER')};"
    f"Server={os.getenv('SQL_SERVER')};"
    f"Database={os.getenv('SQL_DB')};"
    f"Trusted_Connection={os.getenv('SQL_AUTH')};"
) # connection string for sql driver

# OPCUA variables
OPCUA_ENDPOINT = os.getenv('OPCUA_ENDPOINT')
NODEIDS = [
    { 'name': 'temperature','nodeId': 'ns=2;i=2' },
    { 'name': 'gsr','nodeId': 'ns=2;i=3' },
    { 'name': 'oxygen','nodeId': 'ns=2;i=4' },
    { 'name': 'heart','nodeId': 'ns=2;i=5' },
]

# HTTP variables
HTTP_ENDPOINT = os.getenv('HTTP_ENDPOINT')





if __name__ == '__main__':
    # Connect to mqtt
    client = connect_mqtt(BROKER, PORT, CLIENTID)

    # Connect to sql
    sqlConnection = connect_sql(CONNECTION_STR)

    # connect to OPCUA
    opcuaClient = connect_opcua(OPCUA_ENDPOINT)

    # Get cursor to execute SQL queries
    sql = sqlConnection.cursor()

    # Setting http endpoint
    http = Http(HTTP_ENDPOINT)

    # Data retrieved from MQTT
    data = {}

    print('\n------------------------------ Ping Testing to Web Server ------------------------------')
    print('ping', end=' ')
    print(http.get('/ping').json()['message'], '\n\n')

    # MQTT on_message function
    def on_message(client, userdata, msg: MQTTMessage):

        global data

        topic, payload = msg.topic, msg.payload.decode()

        # Adds into data variable
        data[topic] = payload
        
        if len(data.keys()) == len(TOPICS):
            # sql.execute(f"INSERT INTO readings ({','.join(data.keys())})"
            #             f"VALUES ({','.join(data.values())});")
            # sqlConnection.commit()

            # Send data to http web server
            print(http.post('/data', data).json())

            # Update opcua values
            for nodeId in NODEIDS:
                var = opcuaClient.get_node(nodeId['nodeId'])

                var.set_value(data[nodeId['name']])

            print(data)

            data = {}

    # Set on Message
    client.on_message = on_message

    # Subscribe to all the specified topics and adds opcua variables
    for topic in TOPICS:
        client.subscribe(topic)
    
    # Make the client run until 
    client.loop_start()

    input("\n------------------------------ Press Enter to Stop Program ------------------------------\n\n")

    client.loop_stop()
    client.disconnect()
    opcuaClient.disconnect()