
### Enable UFW (Ubuntu Firewall), this is necessary to these ports to accept in coming request

### Check if UFW is active
sudo ufw status

### If active, allow HTTP
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload

cat /etc/nginx/sites-available/default

/home/hello/cverai-backend/dist




### Server config
server {
    listen 80;
    listen [::]:80;
    server_name bot.cverai.com;

    # Redirect all HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name bot.cverai.com;

    # SSL certificate files (Certbot should have added these)
    ssl_certificate /etc/letsencrypt/live/bot.cverai.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/bot.cverai.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # Your application configuration
    location / {
        proxy_pass http://localhost:3000;  # Change port if your app runs on different port
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}


### Restart Nginx to apply changes
nginx -t
systemctl reload nginx