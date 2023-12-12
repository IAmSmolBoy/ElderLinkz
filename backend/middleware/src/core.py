import os
from dotenv import load_dotenv
from paho.mqtt.client import MQTTMessage

from connections.mqtt import connect_mqtt
# from connections.sql import connect_sql
from connections.opcua_client import connect_opcua
from connections.http import Http

load_dotenv()





TOPICS = [
    "temperature",
    "gsr",
    "oxygen",
    "heart",
    "humidity"
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
    f"Trusted_Connection=yes;"
) # connection string for sql driver

# OPCUA variables
OPCUA_ENDPOINT = os.getenv('OPCUA_ENDPOINT')
print(OPCUA_ENDPOINT)
NODEIDS = [
    { 'name': 'temperature','nodeId': 'ns=2;i=2' },
    { 'name': 'gsr','nodeId': 'ns=2;i=3' },
    { 'name': 'oxygen','nodeId': 'ns=2;i=4' },
    { 'name': 'heart','nodeId': 'ns=2;i=5' },
    { 'name': 'humidity','nodeId': 'ns=2;i=6' },
]

# HTTP variables
httpEndpoint = os.getenv('HTTP_ENDPOINT')

# globals = open("../globals.txt", "r+")
# globalsList = globals.read().split("\n")

# for var in globalsList:
#     varName, val = var.split(": ")
#     if varName == "ip":
#         httpEndpoint = f"http://{val}:3000"






if __name__ == '__main__':
    # Connect to mqtt
    client = connect_mqtt(BROKER, PORT, CLIENTID)

    # Connect to sql
    # sqlConnection = connect_sql(CONNECTION_STR)

    # Setting http endpoint
    http = Http(httpEndpoint)
    # http = Http("http://192.168.1.73:3000")

    # connect to OPCUA
    for i in range(5):
        try:
            opcuaClient = connect_opcua(OPCUA_ENDPOINT)

        except:
            print("OPCUA Connection Refused")

    # Get cursor to execute SQL queries
    # sql = sqlConnection.cursor()

    # Data retrieved from MQTT
    data = {}

    print('\n------------------------------ Ping Testing to Web Server ------------------------------')
    print('ping', end=' ')
    enableHttp = True

    try:
        print(http.get('/ping').json()['message'], '\n\n')
    except:
        enableHttp = False
        print("\nError connecting to http")

    # MQTT on_message function
    def on_message(client, userdata, msg: MQTTMessage):

        global data

        topic, payload = msg.topic, msg.payload.decode()

        # Adds into data variable
        data[topic] = payload
        
        if len(data.keys()) == len(TOPICS):
            try:
                # sql.execute(f"INSERT INTO readings ({','.join(data.keys())})"
                #             f"VALUES ({','.join(data.values())});")
                # sqlConnection.commit()

                if enableHttp:
                    # Send data to http web server
                    http.post('/data', data).json()

                # Update opcua values
                for nodeId in NODEIDS:
                    var = opcuaClient.get_node(nodeId['nodeId'])

                    var.set_value(data[nodeId['name']])
                    print(var.get_value())

            except:
                print("Something went wrong")

            # print(data)

            data = {}

    # Set on Message
    client.on_message = on_message

    # Subscribe to all the specified topics and adds opcua variables
    for topic in TOPICS:
        client.subscribe(topic)
    
    # Make the client run until stopped
    client.loop_forever()

    # input("\n------------------------------ Press Enter to Stop Program ------------------------------\n\n")

    # client.loop_stop()
    # client.disconnect()
    # opcuaClient.disconnect()