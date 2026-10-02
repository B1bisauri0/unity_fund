import os
import pyodbc

def get_db_conn():
    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={os.getenv('DB_SERVER')};"
        f"DATABASE={os.getenv('DB_NAME')};"
        f"UID={os.getenv('DB_USER')};"
        f"PWD={os.getenv('DB_PASSWORD')};"
    )
    try:
        connection = pyodbc.connect(connection_string)
        connection.autocommit = True  # Habilitar autocommit
        return connection
    except Exception as e:
        print(f"Error al conectarse a la base de datos: {e}")
        return None
    
def getErrorMessage(errorCode: int):

    con = get_db_conn()
    cursor = con.cursor()

    try:
        cursor.execute(
            """
            DECLARE @errorMessage VARCHAR(255);

            EXECUTE [dbo].[recoverErrorMessage]
                @inErrorCode = ?,
                @outErrorMessage = @errorMessage OUTPUT

            SELECT @errorMessage

            """,
            errorCode
        )

        resultMessage = cursor.fetchone()[0]

        return resultMessage

    except Exception as e:
        return (f"Error al obtener mensaje de error: {e}")
    finally:
        cursor.close()
        con.close()
