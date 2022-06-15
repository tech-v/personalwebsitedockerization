# use a node base image
#have used node a a base image to build the artifact into build directory, then the content of this dir is copied to the webserver. 

FROM node:12-alpine3.14 AS builder

# set maintainer
LABEL maintainer "mehmood"

#create a work dir

WORKDIR /usr/src/

#copy the source code
COPY . .

RUN npm run build

FROM nginx:1.21.0-alpine as production
ENV NODE_ENV production
# Copy built assets from builder
COPY --from=builder /usr/src/build/ /usr/share/nginx/html/
# Add your nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:80 || exit 1

