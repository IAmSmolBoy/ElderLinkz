import pyodbc

def connect_sql(connectionStr: str):
    conn = None
    print("Connecting to SQL Server")

    try:
        conn = pyodbc.connect(connectionStr)
        print("Connected to SQL Server")
    except:
        print("Error connecting to SQL Server")

    return conn