from pydantic import BaseModel
from datetime import date

class UserRegisterInput(BaseModel):
    profileName: str
    profileLastname: str
    profilePassword: str
    personalID: str
    electronicMail: str
    phoneNumber: str
    initialDigitalWalletBalance: float
    isAccountAdmin: bool
    workArea: int
    isAccountVerified: bool

class UserLogInInput(BaseModel):
    electronicMail: str
    profilePassword: str

class CreateProjectInput(BaseModel):
    projectName: str
    projectDescription: str
    moneyGoal: float
    limitDate: date
    projectCategorieID: int
    ownerProfileName: str
    ownerProfileLastname: str

class UpdateProjectInput(BaseModel):
    OwnerProfileName: str
    OwnerProfileLastname: str
    CurrentProjectName: str
    ProjectName: str
    ProjectDescription: str
    LimitDate: date

class MakeDonationInput(BaseModel):
    DonationValue: float
    DonorEmail: str
    DonorProfileName: str
    DonorProfileLastname: str
    ProjectName: str