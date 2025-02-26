FROM node:18-slim

WORKDIR /app

# Copie des fichiers de dépendances
COPY package.json package-lock.json ./

# Installation des dépendances et nettoyage du cache npm
RUN npm ci && npm cache clean --force

# Déplacement des node_modules à la racine pour éviter des problèmes de permission
RUN mv /app/node_modules /node_modules

# Installation de nodemon en global
RUN npm install -g nodemon

# Copie du reste du code source
COPY . .

# Définition de la variable d'environnement pour le port
ENV PORT=3000

# Exposition du port (optionnel, car Nginx gère les entrées)
EXPOSE 3000

# Lancement du serveur Node.js
CMD ["node", "server.js"]
