from fastapi import FastAPI, HTTPException
from db import get_db_conn, getErrorMessage
from models import UserRegisterInput, UserLogInInput, CreateProjectInput, UpdateProjectInput, MakeDonationInput

app = FastAPI()

# DEFAULT ROUTE
@app.get("/")
def readRoot():
    return {"message": "Welcome to the UnityFound Backend :D"}

@app.get("/readQuery")
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

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/registerUser")
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
                @inIsAccountVerified = ?,
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
            user.isAccountVerified,
            user.workArea
        )

        # Obtener el resultado del parámetro de salida
        resultCode = cursor.fetchone()[0]

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            raise HTTPException(status_code=400, detail=errorMessage)
        
        return resultCode

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/userLogIn")
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

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            raise HTTPException(status_code=400, detail=errorMessage)
        
        return resultCode, resultStatus

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/createProject")
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

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            raise HTTPException(status_code=400, detail=errorMessage)
        
        return resultCode

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/updateProject")
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

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            raise HTTPException(status_code=400, detail=errorMessage)
        
        return resultCode

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/makeDonation")
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
        errorMessage = ""

        # Manejo de errores basado en el código de salida
        if resultCode != 0:
            errorMessage = getErrorMessage(resultCode)
            return resultCode, errorMessage
        
        return resultCode, errorMessage

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()