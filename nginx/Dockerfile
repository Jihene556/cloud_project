FROM nginx

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# nginx -p 80:80
# + maybe: -g "daemon off;"
CMD ["nginx", "-p", "80:80", "-g", "daemon off;"]
