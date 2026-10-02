# Unity Fund

A crowdfunding app in the style of GoFundMe, where people publish their needs (personal projects, social causes, community help) and anyone can donate to support them.

Built with **Flutter** on the front end and a **Python (FastAPI)** API on the back end, as a course project at the Instituto Tecnológico de Costa Rica (TEC).

**🔗 Live demo:** [unity-fund-umber.vercel.app](https://unity-fund-umber.vercel.app/)

> **Note:** the backend and database are currently turned off, so the live demo shows the interface only. Signing up, logging in, creating projects and donating won't work there. To try the full app, run the backend locally.

<img width="1149" height="100" alt="Usuario Verificado" src="https://github.com/user-attachments/assets/c6143241-03f8-4429-a46c-5d6f11c4cc12" />
<img width="205" height="917" alt="OpenHamburgerUsuarioNoVerificado" src="https://github.com/user-attachments/assets/afe83c19-5f1e-4d91-b47e-14f4b8acbcdc" />
<img width="1920" height="1927" alt="Mis Proyectos" src="https://github.com/user-attachments/assets/8320cf35-85a1-493d-bdb4-a0649e487427" />
<img width="412" height="917" alt="Mis Donaciones Usuario No Verificado" src="https://github.com/user-attachments/assets/effd3ff6-e2c0-4c0c-9c77-f3af0ba07604" />
<img width="1920" height="1080" alt="Mis Donaciones" src="https://github.com/user-attachments/assets/2a7e4cb8-4b67-46a5-b76d-27ab81af3e18" />
<img width="1920" height="1927" alt="Lista de Proyectos" src="https://github.com/user-attachments/assets/9f756e4d-863e-4ccf-bfef-04345005e909" />
<img width="1920" height="2045" alt="Inicio Usuario Verificado" src="https://github.com/user-attachments/assets/da32fd92-c5e1-47d2-ad10-d64ac2043fea" />
<img width="412" height="917" alt="Inicio Usuario No Verificado" src="https://github.com/user-attachments/assets/f8a75261-8b64-4bae-8ed8-fab9777bc5b0" />
<img width="1920" height="1359" alt="Imagenes Editar CREAR" src="https://github.com/user-attachments/assets/7391d2e6-76a6-4847-aa98-9e3d52ec48f3" />
<img width="1920" height="1359" alt="Imagenes Editar" src="https://github.com/user-attachments/assets/2a006142-4965-4daa-92b3-40fb5597cda9" />
<img width="1920" height="1359" alt="Editar Proyecto" src="https://github.com/user-attachments/assets/7e18f670-551d-4428-9ce7-84a500e9578d" />
<img width="1920" height="1080" alt="Editar Perfil Usuario" src="https://github.com/user-attachments/assets/b304ae84-9740-4a10-be1c-1cfcfc62d07f" />
<img width="1920" height="1080" alt="Donaciones Del Proyecto" src="https://github.com/user-attachments/assets/99e87d53-acb7-4a9d-a292-dd17373c49f8" />
<img width="1920" height="1927" alt="Detalle Proyectos" src="https://github.com/user-attachments/assets/f7eeb14e-7011-43a7-b0c2-6db5e3272f6c" />
<img width="1920" height="1927" alt="Detalle Proyecto Propio" src="https://github.com/user-attachments/assets/90bcda47-bc20-4b84-95c4-86f796f4e454" />
<img width="1920" height="1359" alt="Crear Proyecto 2" src="https://github.com/user-attachments/assets/d64d9311-6f81-4686-b566-ab5a6c6c2ce5" />
<img width="1920" height="1359" alt="Crear Proyecto 1" src="https://github.com/user-attachments/assets/a855e81f-d1ee-4e8e-acf7-622ffa842c8d" />
<img width="1920" height="1080" alt="Cartera Digital" src="https://github.com/user-attachments/assets/ac69969c-1812-4757-85cc-6f4457b3df61" />
<img width="1920" height="1080" alt="Añadir Fondos" src="https://github.com/user-attachments/assets/4c559c43-bb7a-4fe4-be40-70adee28b1f6" />

---

## Features

- **User accounts:** sign up with a profile and a personal wallet, then log in.
- **Fundraising projects:** create a project with a description, a funding goal and a category.
- **Edit projects:** update a project's details at any time.
- **Donations:** donate to any project from your wallet and help it reach its goal.
- **Browse causes:** explore projects by category and see how close each one is to its goal.
- **Cross-platform:** one Flutter codebase that runs on the web, Android, iOS and desktop.


## How it works

```mermaid
flowchart LR
    U[User] --> F[Flutter app<br/>web · mobile]
    F -- HTTP / JSON --> A[FastAPI backend<br/>Python]
    A --> D[(Database)]
```

The Flutter app sends requests to the FastAPI backend, which validates the data with Pydantic models and reads or writes users, projects and donations in the database.

### API endpoints

| Method | Endpoint | What it does |
|---|---|---|
| `POST` | `/registerUser` | Creates a user with their profile, credentials and wallet |
| `POST` | `/userLogIn` | Logs a user in |
| `POST` | `/createProject` | Creates a fundraising project with a goal and categories |
| `POST` | `/updateProject` | Updates an existing project |
| `POST` | `/makeDonation` | Records a donation to a project |
| `GET` | `/readQuery` | Reads data for the app's views |

## Tech

| Layer | Technology |
|---|---|
| Front end | Flutter · Dart |
| Back end | Python · FastAPI · Pydantic · Uvicorn |
| Database | SQL Server (Azure) <!-- add MongoDB here if you used it too --> |
| Hosting | Vercel (web app) |

## Project structure

```
unity_fund/
├── lib/            # Flutter app (screens, widgets, API calls)
├── assets/         # images and other assets
├── web/ android/ ios/ windows/ macos/ linux/   # Flutter platform folders
├── backend/
│   ├── main.py       # FastAPI app and endpoints
│   ├── models.py     # Pydantic models
│   ├── functions.py  # business logic
│   └── db.py         # database connection
└── requirements.txt  # Python dependencies
```

## Getting started

### Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Python 3.10 or newer
- ODBC Driver 17 for SQL Server
- Access to a SQL Server database

### 1. Run the backend

Create a `.env` file (never commit it) with your database credentials:

```
DB_SERVER=your-server.database.windows.net
DB_NAME=your-database
DB_USER=your-user
DB_PASSWORD=your-password
```

Then install the dependencies and start the API:

```bash
pip install -r requirements.txt
uvicorn backend.main:app --reload
```

The API runs at `http://127.0.0.1:8000`, and FastAPI's interactive docs are at `http://127.0.0.1:8000/docs`.

### 2. Run the Flutter app

```bash
flutter pub get
flutter run -d chrome    # or pick an emulator / device
```

## Author

**Tamara Villarevia Navarro** · Computer Engineering student at TEC
[GitHub](https://github.com/B1bisauri0)

<!-- If you built this as a team, add your teammates and what you worked on:
## Team
- Tamara Villarevia Navarro: ...
-->
