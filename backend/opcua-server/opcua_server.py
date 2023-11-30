from opcua import Server, Node

class OpcuaServer:
    def __init__(
        self,
        endpoint: str = 'opc.tcp://127.0.0.1:12345',
        namespace: str = 'namespace',
        objectName: str = 'object',
    ):
        if endpoint != None:
            self.endpoint = endpoint
        else:
            self.endpoint = 'opc.tcp://127.0.0.1:12345'

        if namespace != None:
            self.namespace = namespace
        else:
            self.namespace = 'namespace'

        if objectName != None:
            self.objectName = objectName
        else:
            self.objectName = 'object'

        self.variables = []
        self.server = Server()

    def connect(self):
        self.server.set_endpoint(self.endpoint)
        self.namespaceID = self.server.register_namespace(self.namespace)
        self.objectFolder = self.server.get_objects_node()
        self.objectNode: Node = self.objectFolder.add_object(self.namespaceID, self.objectName)

    def addVar(self, varName: str, value):
        node: Node = self.objectNode.add_variable(self.namespaceID, varName, value)
        node.set_writable()

        print(node.nodeid)

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