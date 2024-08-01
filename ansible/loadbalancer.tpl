upstream frontend {
    server {{ hostvars["frontend"].ansible_host }};
}

upstream backend {
    server {{ hostvars["backend"].ansible_host }};
}

server {
    listen 80;

    server_name {{ hostvars["loadbalancer"].ansible_host }};


# URL path followed with / or /frontend will go into this block 
    location /api/user {
        proxy_pass http://backend/;

        # Pass connection header from initiator to backend server
        proxy_set_header X-Forwarded-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
    }
    
    location / {    
        proxy_pass http://frontend/;

        # Pass connection header from initiator to frontend server
        proxy_set_header X-Forwarded-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;


    }

    
}