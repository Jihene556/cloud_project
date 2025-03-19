#FROM python:3.11-slim
#WORKDIR /app
#COPY requirements.txt .
#RUN pip install --no-cache-dir -r requirements.txt
#COPY . .

#EXPOSE 9000

#CMD ["python", "app.py"]


# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files and directories
COPY . /app/

# Define the environment variable for the port
#EXPOSE 5000

# Healthcheck command (done by Nginx in this case)
# HEALTHCHECK CMD curl --fail http://localhost:5000 || exit 1

# Start the application
CMD ["python", "app.py"]

