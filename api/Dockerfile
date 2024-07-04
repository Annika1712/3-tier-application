# Build with help from: https://www.mytechramblings.com/posts/running-a-sonarqube-scan-when-building-docker-image/

# Choose sdk to build and publish application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set workdir as src
WORKDIR /src

# Install Java for SonarQube
RUN apt-get update && apt install openjdk-17-jdk openjdk-17-jre -y

## Arguments for setting the Sonarqube Token, the Project Key and URI
ARG SONAR_PRJ_KEY
ARG SONAR_TOKEN
ARG SONAR_HOST

# Install Sonarscanner in dotnet container
RUN dotnet tool install --global dotnet-sonarscanner

## Set the dotnet tools folder in the PATH env variable
ENV PATH="${PATH}:/root/.dotnet/tools"

## Install report generator => transfer the dotnet test to a SonarQube readable format
RUN dotnet tool install --global dotnet-reportgenerator-globaltool

# Copy everything (Basic3TierAPI, Basic3Tier.Infrastructure & Basic3Tier.core, tests folders) into container
COPY . ./

# restore/download all the dependencies (Basic3TierAPI has dependencies with Basic3Tier.Core and Basic3Tier.Infrastructure)
RUN dotnet restore "Basic3TierAPI/Basic3TierAPI.csproj"

# change to this directory to start building
WORKDIR "/src/Basic3TierAPI"

## Start scanner
RUN dotnet sonarscanner begin /k:"$SONAR_PRJ_KEY" /d:sonar.host.url="$SONAR_HOST" /d:sonar.login="$SONAR_TOKEN" 

# validate the code, resolve dependencies, and creates the necessary build files to run the application (output in /app/build) Restoring is not necessary since we already did previously
RUN dotnet build -o /app/build

## Run dotnet test setting the output on the /app/build/coverage folder
RUN dotnet test /src/Tests/Basic3TierAPI.Tests/Basic3TierAPI.Tests.csproj --collect:"XPlat Code Coverage" --results-directory /app/build/coverage

## Create the code coverage file in sonarqube format using the cobertura file generated from the dotnet test command
RUN reportgenerator "-reports:/app/build/coverage/*/coverage.cobertura.xml" "-targetdir:coverage" "-reporttypes:SonarQube"

# Stop the sonar scanner
RUN dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"

# Recompile the application and its dependencies based on the project files and source code and creates the necessary assets for deployment. The publish stage does not need the build artifacts from the build stage, but both the build and publish stage are needed for a functionning dotnet application. 
FROM build AS publish
RUN dotnet publish -o /app/publish

# Choose runtime for .dll file to run
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final

WORKDIR /app

# Copy from the publish stage, location /app/publish to current directory
COPY --from=publish /app/publish .

# Define port 80 for http access
EXPOSE 80

ENTRYPOINT ["dotnet", "Basic3TierAPI.dll"]

