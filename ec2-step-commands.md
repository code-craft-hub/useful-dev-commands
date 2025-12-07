
### Enable UFW (Ubuntu Firewall), this is necessary to these ports to accept in coming request

# Check if UFW is active
sudo ufw status

# If active, allow HTTP
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload











/home/hello/cverai-backend/dist