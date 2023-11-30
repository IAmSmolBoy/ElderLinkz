from opcua import Client, Node

def connect_opcua(endpoint):
    client: Client = Client(endpoint)
    client.connect()

    return client