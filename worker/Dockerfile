# Utiliser l'image officielle .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY . .

# Restaurer les dépendances du projet (nuget)
RUN dotnet restore

# Construire le projet
RUN dotnet build --configuration Release

# Publier l'application (créer une version prête pour la production)
RUN dotnet publish --configuration Release --output /app/publish

# Créer l'image finale avec l'image runtime .NET
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app/publish .

# Définir la commande à exécuter pour démarrer l'application
ENTRYPOINT ["dotnet", "Worker.dll"]
