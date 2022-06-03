# Bazooka WordPress base Docker image

## Developing and using the image

Pull the latest image with:

```
docker pull ghcr.io/druidfi/bazooka-wordpress:latest
```

Build image locally:

```
docker build -t ghcr.io/druidfi/bazooka-wordpress .
```

## Creating custom image

Create Dockerfile:

```
FROM ghcr.io/druidfi/bazooka-wordpress:latest

# Add plugins or themes
```
