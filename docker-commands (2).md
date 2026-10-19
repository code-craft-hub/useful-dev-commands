Here’s a practical **Docker CRUD cheat sheet** for **containers and images**, with the commands you’ll use most often.

## 🐳 Container CRUD

| Operation         | Command                          | What it does                            |
| ----------------- | -------------------------------- | --------------------------------------- |
| **Create**        | `docker create --name app nginx` | Creates a container without starting it |
| **Read/List**     | `docker ps`                      | Lists running containers                |
| **Read/List all** | `docker ps -a`                   | Lists running + stopped containers      |
| **Start**         | `docker start app`               | Starts an existing container            |
| **Stop**          | `docker stop app`                | Gracefully stops a container            |
| **Restart**       | `docker restart app`             | Restarts a container                    |
| **Kill**          | `docker kill app`                | Immediately kills it                    |
| **Remove**        | `docker rm app`                  | Removes a stopped container             |
| **Force remove**  | `docker rm -f app`               | Stops and removes it                    |
| **Logs**          | `docker logs app`                | View container logs                     |
| **Follow logs**   | `docker logs -f app`             | Stream logs                             |
| **Inspect**       | `docker inspect app`             | Detailed container metadata             |
| **Stats**         | `docker stats app`               | Live CPU/memory/network stats           |
| **Execute**       | `docker exec -it app sh`         | Open a shell inside container           |

### Typical lifecycle

```bash
docker create --name my-app nginx
docker start my-app
docker ps
docker logs my-app
docker stop my-app
docker rm my-app
```

---

# 🖼️ Image CRUD

| Operation        | Command                               | What it does                    |
| ---------------- | ------------------------------------- | ------------------------------- |
| **Create/Build** | `docker build -t my-app:1.0 .`        | Builds an image from Dockerfile |
| **Read/List**    | `docker images`                       | Lists local images              |
| **Inspect**      | `docker image inspect my-app:1.0`     | Shows image metadata            |
| **Tag**          | `docker tag my-app:1.0 my-app:latest` | Creates another tag             |
| **Pull**         | `docker pull nginx:latest`            | Downloads image from registry   |
| **Push**         | `docker push username/my-app:1.0`     | Uploads image to registry       |
| **Remove**       | `docker rmi my-app:1.0`               | Removes image                   |
| **Force remove** | `docker rmi -f my-app:1.0`            | Forces removal                  |
| **History**      | `docker history my-app:1.0`           | Shows image layers              |

### Typical image lifecycle

```bash
docker build -t my-app:1.0 .
docker images
docker image inspect my-app:1.0
docker tag my-app:1.0 my-app:latest
docker rmi my-app:1.0
```

---

# 🔥 Run a container from an image

This is probably the command you'll use most:

```bash
docker run --name my-nginx -d -p 8080:80 nginx:latest
```

Breakdown:

```text
docker run
   │
   ├── --name my-nginx    Container name
   ├── -d                 Detached/background mode
   ├── -p 8080:80        Host port : Container port
   └── nginx:latest      Image
```

Then:

```bash
docker ps
```

Open:

```text
http://localhost:8080
```

---

# 🧹 Cleanup commands

### Remove stopped containers

```bash
docker container prune
```

### Remove unused images

```bash
docker image prune
```

### Remove all unused images

```bash
docker image prune -a
```

### Remove unused Docker resources

```bash
docker system prune
```

More aggressive:

```bash
docker system prune -a
```

Be careful with `-a`: it can remove images you aren't currently using but may want to keep locally.

---

# 🔍 Very useful inspection commands

### Container

```bash
docker inspect <container>
```

### Image

```bash
docker inspect <image>
```

### Processes inside container

```bash
docker top <container>
```

### Container resource consumption

```bash
docker stats
```

### Container port mappings

```bash
docker port <container>
```

### Container filesystem changes

```bash
docker diff <container>
```

---

# 📦 Copy files

Host → container:

```bash
docker cp ./file.txt my-app:/app/file.txt
```

Container → host:

```bash
docker cp my-app:/app/file.txt ./file.txt
```

---

## ⭐ Commands worth memorizing

If you're working with Docker regularly, these are the core ones:

```bash
docker ps
docker ps -a

docker images

docker build -t app:latest .
docker run -d --name app app:latest

docker start app
docker stop app
docker restart app

docker logs -f app
docker exec -it app sh
docker inspect app
docker stats app

docker rm app
docker rm -f app

docker rmi app:latest

docker system prune
```

Absolutely. Here are the **forceful Docker commands**, organized from normal → aggressive.

## 🧨 Containers

### Force stop / kill immediately

```bash
docker kill <container>
```

Unlike `docker stop`, `docker kill` doesn't give the application time to gracefully shut down.

Multiple containers:

```bash
docker kill container1 container2 container3
```

### Force remove a running container

```bash
docker rm -f <container>
```

This effectively **stops/kills and removes** the container.

```bash
docker rm -f my-app
```

### Force remove all containers

```bash
docker rm -f $(docker ps -aq)
```

Breakdown:

```text
docker ps -aq       → get IDs of ALL containers
docker rm -f        → force-remove them
```

If there are no containers, you may get an error depending on your shell.

---

# 🖼️ Images

### Force remove an image

```bash
docker rmi -f <image>
```

Example:

```bash
docker rmi -f my-app:latest
```

The `-f` is useful when Docker says the image is being used by a stopped/running container.

### Force remove multiple images

```bash
docker rmi -f image1 image2 image3
```

### Force remove ALL local images

```bash
docker rmi -f $(docker images -aq)
```

⚠️ This removes **every Docker image stored locally**.

---

# 💥 Nuclear cleanup

### Remove all containers

```bash
docker rm -f $(docker ps -aq)
```

### Remove all images

```bash
docker rmi -f $(docker images -aq)
```

### Remove all containers + unused resources

```bash
docker system prune -af
```

This is aggressive.

It removes unused:

* containers
* networks
* images
* build cache

### Include unused volumes

```bash
docker system prune -a --volumes -f
```

This is **very destructive** because unused Docker volumes can contain database data.

---

# 🔥 Stop everything immediately

```bash
docker kill $(docker ps -q)
```

Then remove everything:

```bash
docker rm -f $(docker ps -aq)
```

---

# 🧹 Individual resource force commands

| Resource                    | Force command                         |
| --------------------------- | ------------------------------------- |
| Running container           | `docker kill <container>`             |
| Container                   | `docker rm -f <container>`            |
| Image                       | `docker rmi -f <image>`               |
| Volume                      | `docker volume rm -f <volume>`        |
| Network                     | `docker network rm <network>`         |
| Everything unused           | `docker system prune -af`             |
| Everything unused + volumes | `docker system prune -a --volumes -f` |

---

## ⚠️ Especially dangerous commands

### Delete EVERYTHING Docker has

```bash
docker system prune -a --volumes -f
```

### Delete every container

```bash
docker rm -f $(docker ps -aq)
```

### Delete every image

```bash
docker rmi -f $(docker images -aq)
```

### Kill every running container

```bash
docker kill $(docker ps -q)
```
