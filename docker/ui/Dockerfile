# Choose nginx as webserver for frontend apps
FROM nginx:latest

ARG BACKEND_IP

#Important for nginx webserver to run, all html stuff must be in this folder
COPY . /usr/share/nginx/html

ENV BACKEND_IP=$BACKEND_IP

RUN echo "{ \"API_URL\": \"$BACKEND_IP\" }" > /usr/share/nginx/html/configs/config.json

# Expose port 80 for http
EXPOSE 80

#Do not define Entrypoint or CMD - using default Entrypoint