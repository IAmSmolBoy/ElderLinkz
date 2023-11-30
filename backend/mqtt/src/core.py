import os
from dotenv import load_dotenv
from paho.mqtt.client import MQTTMessage

from connections.mqtt import connect_mqtt
from connections.sql import connect_sql
from connections.opcua_client import connect_opcua, set_var

load_dotenv()





TOPICS = [
    "temperature",
    "happy",
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
    { 'name': 'temperature','nodeId': 'ns=2;i=2', },
    { 'name': 'happy','nodeId': 'ns=2;i=3', },
    { 'name': 'oxygen','nodeId': 'ns=2;i=4', },
    { 'name': 'heart','nodeId': 'ns=2;i=5', },
]





if __name__ == '__main__':
    # Connect to mqtt
    client = connect_mqtt(BROKER, PORT, CLIENTID)

    # Connect to sql
    sqlConnection = connect_sql(CONNECTION_STR)

    # connect to OPCUA
    opcuaClient = connect_opcua(OPCUA_ENDPOINT)

    # Get cursor to execute SQL queries
    sql = sqlConnection.cursor()

    # Data retrieved from MQTT
    data = {}

    # MQTT on_message function
    def on_message(client, userdata, msg: MQTTMessage):

        global data

        topic, payload = msg.topic, msg.payload.decode()

        # if opcuaServer.variables == len(TOPICS):
        #     opcuaServer.setVar(topic, payload)
        #     opcuaServer.startServer()

        # Adds into data variable
        data[topic] = payload
        
        if len(data.keys()) == len(TOPICS):
            # sql.execute(f"INSERT INTO readings ({','.join(data.keys())})"
            #             f"VALUES ({','.join(data.values())});")
            # sqlConnection.commit()

            for i, nodeId in enumerate(NODEIDS):
                var = opcuaClient.get_node(nodeId['nodeId'])

                var.set_value(data[nodeId['name']])

            print(data)

            data = {}

    # Set on Message
    client.on_message = on_message

    # Subscribe to all the specified topics and adds opcua variables
    for topic in TOPICS:
        client.subscribe(topic)
        # opcuaServer.addVar(topic, 0)

    # print('test', opcuaServer.variables[0])

    # opcuaServer.startServer()
    
    # Make the client run until 
    client.loop_forever()
