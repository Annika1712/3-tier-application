# Choose nginx as webserver for frontend apps
FROM nginx:latest

ARG AWS_HOST_IP

#Important for nginx webserver to run, all html stuff must be in this folder
COPY . /usr/share/nginx/html

RUN echo '{ "API_URL": "http://'"$AWS_HOST_IP"':82/" }' > /usr/share/nginx/html/configs/config.json

# Expose port 80 for http
EXPOSE 80

#Do not define Entrypoint or CMD - using default Entrypoint