# Docker MXGateway
---
MxGateway components dockerized

MxGateway is an email information traffic management tool for companies and ISPs, where you can have real time email use control.

### Usage
Create a stoped container to store the VOLUMES information. This will be used to store the persistent data (Quarentine, MailQueue, and Database):
```sh
docker create --name mxherovolume mxhero
```
Run mxgateway container:
```sh
docker run -it -d --rm --volumes-from mxherovolumes \
-p 80:80/tcp -p 25:25/tcp -p 26:26/tcp \
mxhero
```
You may use the ENV var MYNETWORKS to set postfix mynetworks on each run of the container: `... -e MYNETWORKS="10.0.0.0/8 127.0.0.0/8 192.168.0.0/16..."`

---
If it's a new install of mxgateway, you will need to initialize the database. For this you may set the ENV var INITDB=1
```sh
docker run -it -d --rm --volumes-from mxherovolumes \
-p 80:80/tcp -p 25:25/tcp -p 26:26/tcp \
-e INITDB=1 -e GLOBAL_ADMIN_PASSWORD=myadminpass
mxhero
```
#### Build
```sh
VERSION=beta2 # Give a name to the build
docker build -t mxhero:install install && \
docker build -t mxhero:config config && \ 
docker build -t mxhero latest && \
docker tag mxhero mxhero:$VERSION && \
cp -rf latest versions/$VERSION
```

### TODO
- Separate components in minimal container images:
    - Engine
    - Web
    - Quarentine
    - SpamAssassin
    - ClamAV
    - Database
 - Create a more granular administration using ENV Vars
