# Use official .NET 8 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the project files
COPY . ./
RUN dotnet publish -c Release -o out

# Use ASP.NET runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Expose port (match the one you use in Program.cs or launchSettings.json)
EXPOSE 5002

# Start the app
ENTRYPOINT ["dotnet", "ContactsManagerApi.dll"]