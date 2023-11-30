from opcua import Client, Node

def connect_opcua(endpoint):
    client: Client = Client(endpoint)
    client.connect()

    return client

def set_var(client: Client, nodeId: str, value):
    var: Node = client.get_node(nodeId)

    var.set_value(value)