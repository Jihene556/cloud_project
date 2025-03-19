#FROM nginx

# Remove default config
#RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx.conf
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf

#EXPOSE 80

# nginx -p 80:80
# + maybe: -g "daemon off;"
#CMD ["nginx", "-p", "80:80", "-g", "daemon off;"]

# Use the Nginx image as base
FROM nginx

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/

# Expose port 80 for Nginx
EXPOSE 80

# Lancer Nginx en mode avant-plan
CMD ["nginx", "-g", "daemon off;"]

