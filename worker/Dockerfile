FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo "Building for TARGETPLATFORM=$TARGETPLATFORM, TARGETARCH=$TARGETARCH, BUILDPLATFORM=$BUILDPLATFORM"

WORKDIR /source

COPY . . 

RUN dotnet restore -a $TARGETARCH

# Compilation et publication de l'application
RUN dotnet publish -c Release -o /app -a $TARGETARCH --self-contained false --no-restore

# Création de l'image finale
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime

WORKDIR /app

# Copie de l'application publiée depuis l'étape de build
COPY --from=builder /source /app

EXPOSE 8000

# Définition du point d'entrée
CMD ["dotnet", "Worker.dll"]