## FOR API CONFIGURATION IN NGINX USE THIS
sudo certbot --nginx -d api.cverai.com

# Check running Node.js processes:
ps aux | grep node
pgrep -a node
pidof node

# Monitor processes in real-time:
top -p $(pgrep -d',' node)

# Check detailed process information:
ps -fp <PID>  # Full details of a specific process
lsof -p <PID>  # List open files and connections for a process
cat /proc/<PID>/status  # Detailed process status

# Install lsof
sudo apt-get install lsof

# Port and Network Monitoring
netstat -tulpn | grep node  # Check ports used by Node.js
lsof -i :3000  # Check what's using port 3000
ss -tulpn | grep node  # Modern alternative to netstat

# View logs in real-time:
tail -f /var/log/app.log  # Follow log file
tail -n 100 /var/log/app.log  # View last 100 lines
less +F /var/log/app.log  # Follow with less (F to follow, Ctrl+C to stop)

# Search logs:
grep "error" /var/log/app.log
grep -i "error" /var/log/app.log  # Case-insensitive
grep -r "error" /var/log/  # Recursive search

# System resources:
free -h  # Memory usage
df -h  # Disk usage
uptime  # System uptime and load
vmstat 1  # Virtual memory statistics

# Kill processes:
kill <PID>  # Graceful termination
kill -9 <PID>  # Force kill
pkill -f "node.*app.js"  # Kill by pattern
killall node  # Kill all node processes (use cautiously!)

pm2 start "npm run dev" --name node-server


# First, fix the ownership of the entire actions-runner directory
sudo chown -R usecver:usecver ~/actions-runner

# Check disk space
df -h

# Check which directories are using the most space in your home directory
du -sh ~/* | sort -h

# Check the current directory size
du -sh ~/actions-runner

# Find the largest directories
sudo du -h / 2>/dev/null | sort -h | tail -20

# Check all files including hidden ones in home directory
du -sh ~/.[!.]* ~/* 2>/dev/null | sort -h | tail -15

# Check everything on the entire system (hidden and non-hidden)
sudo du -sh /{,.[!.]}* 2>/dev/null | sort -h

# Find the 20 largest directories system-wide
sudo du -h / 2>/dev/null | sort -h | tail -20


# Find all files larger than 50MB anywhere on the system
sudo find / -type f -size +50M 2>/dev/null -exec ls -lh {} \; | sort -k5 -h

# Comprehensive home directory check (all files and folders, hidden or not)
du -ah ~ 2>/dev/null | sort -h | tail -30