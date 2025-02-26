FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN python make-data.py

# Install apache2-utils for the 'ab' utility and other dependencies
RUN apt-get update && apt-get install -y apache2-utils bash && rm -rf /var/lib/apt/lists/*

CMD ["bash", "generate-votes.sh"]