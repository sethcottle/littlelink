# LittleLink (Docker version)

This project is a fork of [LittleLink](https://github.com/sethcottle/littlelink). I wanted to create a Docker version of this project that is not modify and kept to true original. And that is what I have done here with the exception of creating the docker files in this repo.

LittleLink is a lightweight DIY alternative to services like [Linktree](https://linktr.ee)
and [many.link](https://many.link/). LittleLink was built using [Skeleton](http://getskeleton.com/), a dead simple, responsive boilerplate—we just stripped out some additional code you wouldn't need and added in branded styles for popular services. 😊

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
 * **Oct 31, 2021** - Pulled latest from sethcottle/littelink. Updated Docker image.
 * **Dec 13, 2021** - Pulled latest. Updated Docker containers with latest content and security patches. 

 # What is littlelink?

![LittleLink](https://cdn.cottle.cloud/littlelink/social-circle.png)

LittleLink is a lightweight DIY alternative to services like [Linktree](https://linktr.ee)
and [many.link](https://www.google.com). LittleLink was built using [Skeleton](http://getskeleton.com/), a dead simple, responsive boilerplate—we just stripped out some additional code you wouldn't need and added in branded styles for popular services. 😊

##### Figma
Duplicate the [LittleLink Template on Figma Community](https://www.figma.com/community/file/846568099968305613) to help plan out and design your LittleLink page.

##### Docker
[Techno Tim](https://github.com/timothystewart6) built [LittleLink-Server](https://github.com/techno-tim/littlelink-server). Check out [his video](https://youtu.be/42SqfI_AjXU)!

[Drew](https://github.com/davisdre) built a [super simple Docker implementation of LittleLink](https://github.com/davisdre/littlelink).

##### Misc
Check out [LittleLink Admin](https://github.com/khashayarzavosh/admin-littlelink) by [Khashayar Zavosh](https://github.com/khashayarzavosh) which lets you host your own admin portal to manage LittleLink! 
