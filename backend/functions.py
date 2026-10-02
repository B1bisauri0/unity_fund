from db import get_db_conn, getErrorMessage
from models import UserRegisterInput, UserLogInInput, CreateProjectInput, UpdateProjectInput, MakeDonationInput

def readQuery(query: str):
    try:
        # Conexión a la base de datos
        conn = get_db_conn()
        cursor = conn.cursor()

        # Ejecutar la consulta
        cursor.execute(query)

        # Obtener los nombres de las columnas
        columns = [col[0] for col in cursor.description]

        # Convertir las filas en diccionarios
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]

        # Cerrar la conexión
        conn.close()

        # Retornar los resultados en formato JSON
        return results

    # Si hay algún tipo de error, se lanza una excepción
    # y se devuelve un diccionario vacío
    except Exception as e:
        return {}

async def registerUser(user: UserRegisterInput):
    conn = get_db_conn()
    cursor = conn.cursor()

    try:
        # Llamada al procedimiento almacenado
        cursor.execute(
            """
            DECLARE @ResultCode INT;

            EXEC [dbo].[userRegister] 
                @inProfileName = ?, 
                @inProfileLastname = ?, 
                @inProfilePassword = ?, 
                @inPersonalID = ?, 
                @inElectronicMail = ?, 
                @inPhoneNumber = ?, 
                @inInitialDigitalWalletBalance = ?, 
                @inIsAccountAdmin = ?, 
                @inWorkArea = ?, 
                @outResultCode = @ResultCode OUTPUT;
                
            SELECT @ResultCode AS ResultCode;
            """,
            user.profileName,
            user.profileLastname,
            user.profilePassword,
            user.personalID,
            user.electronicMail,
            user.phoneNumber,
            user.initialDigitalWalletBalance,
            user.isAccountAdmin,
            user.workArea
        )

        # Obtener el resultado del parámetro de salida
        resultCode = cursor.fetchone()[0]
        errorMessage = ""

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, errorMessage
        
        return resultCode, errorMessage

    except Exception as e:
        return 500, str(e)
    finally:
        cursor.close()
        conn.close()

async def userLogIn(user: UserLogInInput):
    conn = get_db_conn()
    cursor = conn.cursor()

    try:
        # Llamada al procedimiento almacenado
        cursor.execute(
            """
            DECLARE @resultCode INT, @resultStatus INT;

            EXEC [dbo].[userLogIn] 
                @inElectronicMail = ?, 
                @inProfilePassword = ?, 
                @outResultCode = @resultCode OUTPUT, 
                @outResultStatus = @resultStatus OUTPUT;
                
            SELECT @resultCode AS ResultCode, @resultStatus AS ResultStatus;
            """,
            user.electronicMail,
            user.profilePassword
        )

        # Obtener el resultado del parámetro de salida
        result = cursor.fetchone()
        resultCode, resultStatus = result[0], result[1]
        errorMessage = ""

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, resultStatus, errorMessage
        
        return resultCode, resultStatus, errorMessage

    except Exception as e:
        return 500, 0, str(e)
    finally:
        cursor.close()
        conn.close()

async def createProject(projectData: CreateProjectInput):

    conn = get_db_conn()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            DECLARE @ResultCode INT;

            EXEC [dbo].[createProject] 
                @inProjectName = ?, 
                @inProjectDescription = ?, 
                @inMoneyGoal = ?, 
                @inLimitDate = ?, 
                @inProjectCategorie_id = ?, 
                @inOwnerProfileName = ?, 
                @inOwnerProfileLastname = ?, 
                @outResultCode = @ResultCode OUTPUT;
                
            SELECT @ResultCode AS ResultCode;
            """,
            projectData.projectName,
            projectData.projectDescription,
            projectData.moneyGoal,
            projectData.limitDate,
            projectData.projectCategorieID,
            projectData.ownerProfileName,
            projectData.ownerProfileLastname
        )

        # Obtener el resultado del parámetro de salida
        resultCode = cursor.fetchone()[0]

        errorMessage = ""

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, errorMessage
        
        return resultCode, errorMessage

    except Exception as e:
        return 500, str(e)
    finally:
        cursor.close()
        conn.close()

async def updateProject(updateProjectData: UpdateProjectInput):

    conn = get_db_conn()
    cursor = conn.cursor()

    try:

        cursor.execute(
            """
            DECLARE @ResultCode INT;

            EXEC [dbo].[updateProject] 
                @inOwnerProfileName = ?, 
                @inOwnerProfileLastname = ?, 
                @inCurrentProjectName = ?, 
                @inProjectName = ?, 
                @inProjectDescription = ?, 
                @inLimitDate = ?, 
                @outResultCode = @ResultCode OUTPUT;
                
            SELECT @ResultCode AS ResultCode;
            """,
            updateProjectData.OwnerProfileName,
            updateProjectData.OwnerProfileLastname,
            updateProjectData.CurrentProjectName,
            updateProjectData.ProjectName,
            updateProjectData.ProjectDescription,
            updateProjectData.LimitDate
        )

        # Obtener el resultado del parámetro de salida
        resultCode = cursor.fetchone()[0]

        errorMessage = ""

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, errorMessage 
        
        return resultCode, errorMessage

    except Exception as e:
        return 500, str(e)
    finally:
        cursor.close()
        conn.close()

async def makeDonation(donationData: MakeDonationInput):
    
    conn = get_db_conn()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            DECLARE @ResultCode INT;

            EXEC [dbo].[makeDonation] 
                @inDonationValue = ?, 
                @inDonorEmail = ?, 
                @inDonorProfileName = ?, 
                @inDonorProfileLastname = ?, 
                @inProjectName = ?, 
                @outResultCode = @ResultCode OUTPUT;
                
            SELECT @ResultCode AS ResultCode;
            """,
            donationData.DonationValue,
            donationData.DonorEmail,
            donationData.DonorProfileName,
            donationData.DonorProfileLastname,
            donationData.ProjectName
        )

        # Obtener el resultado del parámetro de salida
        resultCode = cursor.fetchone()[0]

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, errorMessage
        
        return resultCode, errorMessage

    except Exception as e:
        return 500, str(e)
    finally:
        cursor.close()
        conn.close()