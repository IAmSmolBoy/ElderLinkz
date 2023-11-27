import os
from opcua import OpcuaServer

# OPCUA variables
ENDPOINT = os.getenv('ENDPOINT')
NAMESPACE = os.getenv('NAMESPACE')
OBJECT_NAME = os.getenv('OBJECT_NAME')

# Connect to OPCUA
opcuaServer = OpcuaServer(
    endpoint=ENDPOINT,
    namespace=NAMESPACE,
    objectName=OBJECT_NAME
)
opcuaServer.connect()