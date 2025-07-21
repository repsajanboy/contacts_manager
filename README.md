# Contacts Manager Application

A full-stack Contacts Manager system built with a **.NET 8 RESTful API**, **Flutter mobile app**, and **SQL Server** as the database. This app supports basic contact CRUD operations along with profile picture uploads.

---

## 📌 Project Overview

This project includes:

- A **standalone, self-contained .NET 8 API**
- A **Flutter app** for managing and viewing contacts
- **Image upload and display support**
- **SQL Server** as the backend database (can be run locally or in Docker)
- Designed for cross-platform development and deployment

---

## 🧰 Technologies Used

### Backend (.NET API)
- .NET 8
- ASP.NET Core Web API
- Entity Framework Core
- SQL Server
- Docker & Docker Compose

### Frontend (Flutter App)
- Flutter
- BLoC for state management
- Image Picker
- HTTP for API interaction
- Shared Preferences for local storage

---

## ⚙️ Setup Instructions

### 🔧 1. Clone the Project

```bash
git clone https://github.com/your-username/contacts-manager.git
cd contacts-manager

```
---

### SQL Script

CREATE DATABASE ContactsDb;
GO

USE ContactsDb;
GO

CREATE TABLE Contacts (
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(50),
    ProfilePicture NVARCHAR(MAX),
    DateCreated DATETIME DEFAULT GETDATE()
);

---

### NOTES

I only have macOS so I installed docker to run MSSQL:
Please use connection string "Server=localhost,1433;Database=ContactManagerDB;User Id=sa;Password=QAContactManager2025;Encrypt=false;"

And build docker with: 
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=QAContactManager2025" \
   -p 1433:1433 --name sqlserver \
   -d mcr.microsoft.com/mssql/server


##Limitation
Please use http for now instead of https it is configured to accept http.
