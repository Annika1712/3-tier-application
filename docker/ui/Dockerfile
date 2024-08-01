# Choose nginx as webserver for frontend apps
FROM nginx:latest

ARG LOADBALANCER

#Important for nginx webserver to run, all html stuff must be in this folder
COPY . /usr/share/nginx/html

ENV LOADBALANCER=$LOADBALANCER

RUN echo "{ \"API_URL\": \"$LOADBALANCER/\" }" > /usr/share/nginx/html/configs/config.json

# Expose port 80 for http
EXPOSE 80

#Do not define Entrypoint or CMD - using default Entrypoint