upstream webs {
   server ${web-0-ip};
   server ${web-1-ip};
}

server {
    listen 80;
    server_name _;

      location / {
        proxy_pass http://webs/;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_set_header X-Real-IP $remote_addr;
      }
}