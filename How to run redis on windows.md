# Redis Server Operation

# Update package manager
sudo apt update

# Install curl
sudo apt install curl

# Add Redis official repository
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

# Install Redis
sudo apt update && sudo apt install redis -y

# Start Redis server
sudo service redis-server start

# Check status
sudo service redis-server status

# Stop Redis server
sudo service redis-server stop

# Restart Redis server
sudo service redis-server restart

# Redis Client Operations

# Test connection from WSL
redis-cli ping
* Expected output: PONG

# Connect to Redis CLI
redis-cli

# Basic Redis commands
set mykey "Hello World"
get mykey
keys "*"



# COMMANDS FOR WINDOWS
net start redis

net stop redis

redis-cli ping

redis-server --version

Ubuntu : ss -ltnp | grep 6379
windows: netstat -ano | findstr 6379


# Check Redis service status
sudo systemctl status redis-server
# or
sudo systemctl status redis

# Stop Redis service
sudo systemctl stop redis-server

# Start Redis service
sudo systemctl start redis-server

# Restart Redis service
sudo systemctl restart redis-server

# Enable/disable auto-start on boot
sudo systemctl enable redis-server   # Auto-start on boot
sudo systemctl disable redis-server  # Don't auto-start on boot




# 1. Starting and Stopping Redis
Starting Redis Server

# Start Redis server with default configuration
redis-server

# Start with custom configuration file
redis-server /path/to/redis.conf

# Start on specific port
redis-server --port 6380

# Start in background (daemon mode)
redis-server --daemonize yes

# Start with custom settings
redis-server --port 6379 --dbfilename dump.rdb --dir /var/lib/redis/
Stopping Redis Server

# Graceful shutdown (recommended)
redis-cli shutdown

# Force shutdown
redis-cli shutdown nosave

# Kill process (not recommended)
pkill redis-server

# Shutdown specific instance
redis-cli -p 6380 shutdown
Check Redis Status

# Check if Redis is running
redis-cli ping
# Response: PONG (if running)

# Get server information
redis-cli info

# Check Redis version
redis-cli --version


# Basic string operations
SET key value                    # Set string value
GET key                         # Get string value
MSET key1 value1 key2 value2    # Set multiple keys
MGET key1 key2                  # Get multiple keys
DEL key                         # Delete key

# String with expiration
SET key value EX 60             # Expire in 60 seconds
SETEX key 60 value              # Same as above
SET key value PX 60000          # Expire in 60000 milliseconds

# Conditional set
SET key value NX                # Set only if key doesn't exist
SET key value XX                # Set only if key exists

# Atomic operations
INCR counter                    # Increment by 1
DECR counter                    # Decrement by 1
INCRBY counter 10               # Increment by 10
DECRBY counter 5                # Decrement by 5
INCRBYFLOAT price 0.1           # Increment float value

# String operations
APPEND key value                # Append to string
STRLEN key                      # Get string length
GETRANGE key 0 10               # Get substring
SETRANGE key 0 "new"            # Replace part of string

# List operations
LPUSH mylist value1             # Push to left (beginning)
RPUSH mylist value2             # Push to right (end)
LPOP mylist                     # Pop from left
RPOP mylist                     # Pop from right
LLEN mylist                     # Get list length
LRANGE mylist 0 -1              # Get all elements
LINDEX mylist 0                 # Get element by index
LSET mylist 0 "newvalue"        # Set element by index
LREM mylist 2 "value"           # Remove 2 occurrences of "value"

# Blocking operations
BLPOP mylist 10                 # Block and pop from left (10s timeout)
BRPOP mylist 10                 # Block and pop from right
BRPOPLPUSH source dest 10       # Block, pop from source, push to dest

# List trimming
LTRIM mylist 0 99               # Keep only first 100 elements


# Set operations
SADD myset value1 value2        # Add members to set
SMEMBERS myset                  # Get all members
SREM myset value1               # Remove member
SCARD myset                     # Get set size
SISMEMBER myset value1          # Check if member exists
SRANDMEMBER myset 2             # Get 2 random members
SPOP myset                      # Remove and return random member

# Set operations between sets
SUNION set1 set2                # Union of sets
SINTER set1 set2                # Intersection of sets
SDIFF set1 set2                 # Difference of sets
SUNIONSTORE dest set1 set2      # Store union in dest
SINTERSTORE dest set1 set2      # Store intersection in dest
SDIFFSTORE dest set1 set2       # Store difference in dest

# Hash operations
HSET user:1000 name "John" age 30    # Set hash fields
HGET user:1000 name                  # Get hash field
HMSET user:1000 email "john@email.com" city "NYC"  # Set multiple fields
HMGET user:1000 name age             # Get multiple fields
HGETALL user:1000                    # Get all fields and values
HDEL user:1000 age                   # Delete hash field
HEXISTS user:1000 name               # Check if field exists
HKEYS user:1000                      # Get all field names
HVALS user:1000                      # Get all values
HLEN user:1000                       # Get number of fields

# Atomic hash operations
HINCRBY user:1000 age 1              # Increment integer field
HINCRBYFLOAT user:1000 score 0.1     # Increment float field
HSETNX user:1000 created_at "2023"   # Set only if field doesn't exist

# Sorted set operations
ZADD leaderboard 100 "player1" 200 "player2"  # Add members with scores
ZRANGE leaderboard 0 -1                       # Get all members (by rank)
ZRANGE leaderboard 0 -1 WITHSCORES            # Get members with scores
ZREVRANGE leaderboard 0 9                     # Get top 10 (highest scores)
ZRANK leaderboard "player1"                   # Get rank of member
ZREVRANK leaderboard "player1"                # Get reverse rank
ZSCORE leaderboard "player1"                  # Get score of member
ZREM leaderboard "player1"                    # Remove member
ZCARD leaderboard                             # Get number of members

# Score-based queries
ZRANGEBYSCORE leaderboard 100 200             # Get members with score 100-200
ZREVRANGEBYSCORE leaderboard 200 100          # Reverse order
ZCOUNT leaderboard 100 200                    # Count members in score range
ZREMRANGEBYSCORE leaderboard 0 50             # Remove members with score 0-50
ZREMRANGEBYRANK leaderboard 0 9               # Remove bottom 10 members

# Atomic operations
ZINCRBY leaderboard 10 "player1"              # Increment score




# Setup multiple leaderboards
ZADD fps_leaderboard 1500 "player1" 1200 "player2" 1800 "player3"
ZADD rpg_leaderboard 2500 "playerA" 2200 "playerB" 2800 "playerC"

# Pop highest score from any leaderboard (timeout 10 seconds)
BZMPOP 10 2 fps_leaderboard rpg_leaderboard MAX

# Pop lowest 2 scores from any leaderboard
BZMPOP 5 2 fps_leaderboard rpg_leaderboard MIN COUNT 2

# Pop from single key with timeout
BZMPOP 3 1 fps_leaderboard MAX COUNT 1

# Setup priority queues
ZADD urgent_tasks 100 "backup_database" 95 "fix_bug" 90 "deploy_code"
ZADD normal_tasks 50 "update_docs" 45 "clean_logs"

# Worker waits 30 seconds for highest priority task from any queue
BZPOPMAX urgent_tasks normal_tasks 30

# Worker waits indefinitely (0 timeout)
BZPOPMAX urgent_tasks 0

# Multiple workers on different queues
BZPOPMAX maintenance_tasks 60

# Setup recommendation data
ZADD user1_likes 5 "movie1" 4 "movie2" 3 "movie3"
ZADD user2_likes 4 "movie1" 5 "movie4" 3 "movie2"

# Find common movies (default SUM aggregation)
ZINTER 2 user1_likes user2_likes

# With scores shown
ZINTER 2 user1_likes user2_likes WITHSCORES

# Using weights (boost user1's preferences)
ZINTER 2 user1_likes user2_likes WEIGHTS 2 1 WITHSCORES

# MIN aggregation (conservative scoring)
ZINTER 2 user1_likes user2_likes AGGREGATE MIN WITHSCORES

# MAX aggregation (optimistic scoring)
ZINTER 2 user1_likes user2_likes AGGREGATE MAX WITHSCORES

# Three-set intersection
ZADD user3_likes 4 "movie1" 2 "movie5"
ZINTER 3 user1_likes user2_likes user3_likes WEIGHTS 1 1 2 AGGREGATE SUM WITHSCORES

# Setup alphabetical data
ZADD dictionary 0 "apple" 0 "banana" 0 "cherry" 0 "date" 0 "elderberry"

# Count words from 'a' to 'c'
ZLEXCOUNT dictionary [a [c

# Count all words starting with 'a'
ZLEXCOUNT dictionary [a [b

# Count using exclusive ranges
ZLEXCOUNT dictionary (apple (cherry

# Count all entries
ZLEXCOUNT dictionary - +

# Count words after 'banana'
ZLEXCOUNT dictionary (banana +








# Bitmap operations
SETBIT bitmap 10 1                  # Set bit at position 10
GETBIT bitmap 10                    # Get bit at position 10
BITCOUNT bitmap                     # Count set bits
BITCOUNT bitmap 0 10                # Count set bits in byte range
BITOP AND dest bitmap1 bitmap2      # Bitwise AND operation
BITOP OR dest bitmap1 bitmap2       # Bitwise OR operation
BITPOS bitmap 1                     # Find first set bit

# Key existence and information
EXISTS key                      # Check if key exists
TYPE key                        # Get key type
KEYS pattern                    # Find keys matching pattern (avoid in production)
SCAN 0 MATCH prefix* COUNT 10   # Scan keys with cursor (production-safe)
RANDOMKEY                       # Get random key

# Key expiration
EXPIRE key 60                   # Expire in 60 seconds
EXPIREAT key 1609459200         # Expire at Unix timestamp
PEXPIRE key 60000               # Expire in 60000 milliseconds
TTL key                         # Get time to live in seconds
PTTL key                        # Get time to live in milliseconds
PERSIST key                     # Remove expiration

# Key renaming and copying
RENAME oldkey newkey            # Rename key
RENAMENX oldkey newkey          # Rename only if newkey doesn't exist
COPY source dest                # Copy key (Redis 6.2+)

# Key sorting
SORT mylist                     # Sort list/set/sorted set
SORT mylist ALPHA               # Sort alphabetically
SORT mylist DESC                # Sort descending
SORT mylist LIMIT 0 10          # Sort with pagination

# Database operations (0-15 by default)
SELECT 1                        # Select database 1
DBSIZE                          # Get number of keys in current DB
FLUSHDB                         # Delete all keys in current DB
FLUSHALL                        # Delete all keys in all databases
SWAPDB 0 1                      # Swap database 0 and 1

# Transaction example
MULTI                           # Start transaction
SET key1 value1
SET key2 value2
INCR counter
EXEC                            # Execute transaction

# Watch keys for changes
WATCH mykey
MULTI
SET mykey newvalue
EXEC                            # Will fail if mykey changed

# Discard transaction
MULTI
SET key value
DISCARD                         # Cancel transaction

