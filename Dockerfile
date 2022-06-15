# use a node base image
FROM node:16

# set maintainer
LABEL maintainer "mehmood"

#create a work dir

WORKDIR /usr/src/

#copy the source code
COPY * /usr/src/

RUN npm i

RUN npm start

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8080 || exit 1

# tell docker what port to expose
EXPOSE 8080
