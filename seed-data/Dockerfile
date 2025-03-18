#FROM python:3.9-slim

#WORKDIR /app

#COPY . .

#RUN python make-data.py

# Install apache2-utils for the 'ab' utility and other dependencies
#RUN apt-get update && apt-get install -y apache2-utils bash && rm -rf /var/lib/apt/lists/*

#CMD ["bash", "generate-votes.sh"]

# Use Python 3.9 slim image as base
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy necessary files and install dependencies
COPY make-data.py /app/
COPY generate-votes.sh /app/
RUN apt-get update && apt-get install -y apache2-utils

# Run the make-data.py and generate-votes.sh script
CMD ["bash", "generate-votes.sh"]
