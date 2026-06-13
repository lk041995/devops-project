# Lightweight static web server
FROM nginx:alpine

# Copy site files into the nginx web root
COPY index.html /usr/share/nginx/html/
COPY style.css  /usr/share/nginx/html/

EXPOSE 80

# nginx:alpine already runs nginx in the foreground by default
