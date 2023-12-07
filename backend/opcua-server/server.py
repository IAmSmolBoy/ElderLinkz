import os
from opcua_server import OpcuaServer

# OPCUA variables
ENDPOINT = os.getenv('ENDPOINT')
NAMESPACE = os.getenv('NAMESPACE')
OBJECT_NAME = os.getenv('OBJECT_NAME')

VARIABLES = [
    "temperature",
    "gsr",
    "oxygen",
    "heart",
]

# Connect to OPCUA
opcuaServer = OpcuaServer(
    endpoint=ENDPOINT,
    namespace=NAMESPACE,
    objectName=OBJECT_NAME
)
opcuaServer.connect()

for varirable in VARIABLES:
    opcuaServer.addVar(varirable, 0.0)

opcuaServer.startServer()