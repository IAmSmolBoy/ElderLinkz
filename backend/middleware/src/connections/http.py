from requests import get, post

class Http:
    def __init__(self, host: str = None):
        if host != None:
            self.host = host
        else:
            self.host = 'http://localhost:3000'

    def get(self, path: str):
        return get(self.host + path)

    def post(self, path: str, body: dict):
        return post(self.host + path, body)