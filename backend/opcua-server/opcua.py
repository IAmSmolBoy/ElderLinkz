from opcua import Server, Client

class OpcuaServer:
    def __init__(
        self,
        endpoint: str = 'opc.tcp://127.0.0.1:12345',
        namespace: str = "namespace",
        objectName: str = "object",
    ):
        self.endpoint = endpoint
        self.namespace = namespace
        self.objectName = objectName
        self.variables = []

        self.server = Server()

    def connect(self):
        self.server.set_endpoint(self.endpoint)
        self.namespaceID = self.server.register_namespace(self.namespace)
        self.objectFolder = self.server.get_objects_node()
        self.objectNode = self.objectFolder.add_object(self.namespaceID, self.objectName)

    def addVar(self, varName: str, value):
        node = self.objectNode.add_variable(self.namespaceID, varName, value)
        node.set_writable()

        self.variables.append(node)

    def setVar(self, varName: str, value):
        index = self.variables.index(varName)

        self.variables[index].set_value(value)
        # node = self.objectNode(self.namespaceID, varName, value)
        # node.set_writable()

        # self.variables.append(node)

    def startServer(self):
        self.server.start()
        input("Press Enter to Stop OPCUA Server.\n")
        self.server.stop()