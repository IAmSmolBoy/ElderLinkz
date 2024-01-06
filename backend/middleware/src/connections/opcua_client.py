from opcua import Client

def connect_opcua(endpoint):
    client: Client = Client(endpoint)
    client.connect()

    return client