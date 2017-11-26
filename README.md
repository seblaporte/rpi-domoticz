# rpi-domoticz

Domoticz server with Docker on Raspberry Pi with Xiaomi Vacuum plugin integrated

Designed to run with Traefik proxy (add HTTPS with Let's Encrypt)

## Requirements

- Docker installed on a Raspberry Pi
- Traefik running and configured with an external network attached (wan)

## Installation

### Build

Run a build to create your image :

```bash
docker build -t rpi-domoticz-v1 .
```

### Configuration

Create your own configuration file based on __.env.sample__.

```bash
mv .env.sample .env
```

Edit this __.env__ file :

```bash
DOMOTICZ_IMAGE=<The name of your built image in the first step>
EXTERNAL_NETWORK=<External network name used by Traefik>
HOSTNAME=<Hostname for Traefik redirections>
DOMOTICZ_PORT=<Domoticz exposed port in local network>
AUTH=<Basic auth credentials>
```

Basic auth credentials can be generated from [http://www.htaccesstools.com/](http://www.htaccesstools.com/htpasswd-generator/)

You can check your configuration with `docker-compose config` command.

### Run

Use `docker-compose up -d` to start Domoticz
