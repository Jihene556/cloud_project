FROM python:3.9-slim
WORKDIR /app

# Install required system package for benchmarking (apache2-utils)
RUN apt-get update && apt-get install -y apache2-utils && rm -rf /var/lib/apt/lists/*

# Copy the necessary scripts into the container
COPY make-data.py generate-votes.sh ./

# Fix line endings for generate-votes.sh
RUN sed -i 's/\r$//' generate-votes.sh

# Execute make-data.py during the build phase
RUN python make-data.py

# Grant execute permissions to generate-votes.sh
# RUN chmod +x generate-votes.sh

# Define the startup command
CMD ["/app/generate-votes.sh"]