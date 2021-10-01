# LittleLink (Docker version)

This project is a fork of [LittleLink](https://github.com/sethcottle/littlelink). I wanted to create a Docker version of this project that is not modify and kept to true original. And that is what I have done here with the exception of creating the docker files in this repo.

## Usage

To help you start with creating a container from this image, you can either use docker-compose or the docker command line. This container image is published on [DockerHub](https://hub.docker.com/r/davisdre/littlelink). 

### docker-compose (recommended)

```
version: "3"
services: 
  little-link:
    image: davisdre/littlelink:latest
    container_name: littlelink-server
    ports: 
      - 80:80
```

### docker commandline

```
docker run -d \
  --name=littlelink-server \
  -p 80:80
  davisdre/littlelink:latest
```

## Support
If you would like to support this docker build, please feel free to buy me a coffee!

<a href="https://www.buymeacoffee.com/davisdredotcom"> <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210"></a>

## Versions
 * **Sep 1, 2021** - Initial pull.
 * **Oct 1, 2021** - Pulled latest. Updated Docker with latest content.

 # What is littlelink?

![LittleLink](https://cdn.cottle.cloud/littlelink/social-circle.png)

LittleLink is a lightweight DIY alternative to services like [Linktree](https://linktr.ee)
and [many.link](https://www.google.com). LittleLink was built using [Skeleton](http://getskeleton.com/), a dead simple, responsive boilerplate—we just stripped out some additional code you wouldn't need and added in branded styles for popular services. 😊

![Themes](https://cdn.cottle.cloud/littlelink/themes.png)

LittleLink has more than 20 company button styles you can use and we'll be throwing more in soon. You'll also find a light and dark theme ready to go. Not a fan of the colors? Update `skeleton-light.css` or `skeleton-dark.css` to the HEX values of your choosing. 

![Performance](https://cdn.cottle.cloud/littlelink/performance.png)

Using [Skeleton](http://getskeleton.com/) let us build something that loads quickly & doesn't have any of the unnecessary bloat you would get from using a large framework for a page that requires nothing more than simplicity. LittleLink scored a 99/100 in performance when tested with [Google Lighthouse](https://developers.google.com/web/tools/lighthouse).