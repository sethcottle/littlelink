# Docker for LittleLink

Docker configuration to run LittleLink in a container.

## File Structure

- `Dockerfile`: Defines how the image is built using nginx:alpine
- `compose.yaml`: Configuration for Docker Compose with volumes for development
- `.dockerignore`: Excludes unnecessary files from the image

## Technical Details

### Base Image
- Uses `nginx:alpine` for minimal image size (~20MB)
- Includes gzip compression for static files
- Optimized cache configuration for CSS, JavaScript, and images
- Configured to forward nginx logs to Docker log collector

### Volumes and Ports
- Mounts the project root directory as a volume for live development
- Exposes port 80 in the container, mapped to 8080 on the host

## Common Use Cases

### Creating Personal Link Pages for Different People

One of the main advantages of this Docker setup is how easily you can create multiple personalized instances of LittleLink:

```bash
# Clone the repository
git clone https://github.com/sethcottle/littlelink.git littlelink-john

# Customize the content for John
cd littlelink-john
# Edit index.html with John's links, customize images, etc.

# Build a Docker image for John's page
docker build -f docker/Dockerfile -t littlelink-john .

# Run John's page on port 8080
docker run -d --name john-links -p 8080:80 littlelink-john
```

For additional pages:

```bash
# Similarly for another person
git clone https://github.com/sethcottle/littlelink.git littlelink-jane
cd littlelink-jane
# Customize for Jane...

# Build and run on a different port
docker build -f docker/Dockerfile -t littlelink-jane .
docker run -d --name jane-links -p 8081:80 littlelink-jane
```

This approach allows you to:
- Maintain separate customized sites for different people
- Run multiple instances on different ports
- Update each site independently
- Easily deploy to various environments

## Development vs. Production

There are two main ways to use Docker with LittleLink:

### Development Workflow

In development, we use Docker Compose with mounted volumes to allow for live editing:

```bash
# Start development environment
docker compose -f docker/compose.yaml up
```

This configuration:
- Mounts local files as a volume, so changes are reflected immediately
- Requires manual browser refresh to see changes
- Is ideal for testing and development

### Production Workflow

For production, you have two options:

#### Option 1: Production with Docker Compose

Create a production-specific docker-compose file:

```yaml
# docker/compose.prod.yaml

services:
  web:
    image: yourname/littlelink:latest
    restart: always
    ports:
      - "8080:80"
    # Optional volume for customizable content
    volumes:
      - /path/on/server/custom-content:/usr/share/nginx/html
```

Deploy using:

```bash
# Build and tag the image
docker build -f docker/Dockerfile -t yourname/littlelink:latest .

# Run in production with compose
docker compose -f docker/compose.prod.yaml up -d
```

#### Option 2: Production with Docker Run

```bash
# Build a production image
docker build -f docker/Dockerfile -t yourname/littlelink:latest .

# Run in production (no volumes mounted)
docker run -d --name littlelink -p 80:80 --restart always yourname/littlelink:latest
```

## Using Volumes in Production

You can customize the content in production by mounting a local directory:

```bash
# Prepare a directory with your custom content
mkdir -p /path/on/server/custom-content
cp -r index.html css/ images/ /path/on/server/custom-content/

# Run with the custom content mounted
docker run -d --name littlelink -p 80:80 \
  -v /path/on/server/custom-content:/usr/share/nginx/html \
  yourname/littlelink:latest
```

With Docker Compose:

```yaml
services:
  web:
    image: yourname/littlelink:latest
    ports:
      - "80:80"
    volumes:
      - /path/on/server/custom-content:/usr/share/nginx/html
```

This approach:
- Allows content customization without rebuilding the image
- Makes it easy to update content independently of the container

## Docker Commands Reference

### Development Commands

```bash
# Start in development mode
docker compose -f docker/compose.yaml up

# Start in background
docker compose -f docker/compose.yaml up -d

# Stop container
docker compose -f docker/compose.yaml down

# View logs (including HTTP request logs)
docker compose -f docker/compose.yaml logs -f
```

### Production Commands

```bash
# Build production image
docker build -f docker/Dockerfile -t yourname/littlelink:latest .

# Run production container
docker run -d --name littlelink -p 80:80 yourname/littlelink:latest

# View logs for the running container
docker logs -f littlelink
```

## Customization

### Change Port
Edit `docker/compose.yaml` for development:
```yaml
ports:
  - "8081:80"  # Change 8080 to desired port
```

Or specify port when running production container:
```bash
docker run -p 8081:80 yourname/littlelink:latest
```

### Additional nginx Configuration
To modify the nginx configuration, you can edit the `Dockerfile` and add your own configuration:

```dockerfile
# Example: add custom configuration
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
```

## Deploying to Production

### Docker on VPS
```bash
# Pull image
docker pull yourname/littlelink:latest

# Run container
docker run -d --name littlelink -p 80:80 yourname/littlelink:latest

# With restart policy for auto-recovery
docker run -d --name littlelink --restart unless-stopped -p 80:80 yourname/littlelink:latest
```

### Multiple Sites on One Server
You can run multiple LittleLink instances on the same server:

```bash
# Run first site on port 8080
docker run -d --name site1 -p 8080:80 littlelink-site1

# Run second site on port 8081
docker run -d --name site2 -p 8081:80 littlelink-site2
```

