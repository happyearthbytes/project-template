# Need to define the base image for copying from
ARG docker_registry
FROM ${docker_registry}/tools_download_basic:latest as tools_download_basic

FROM node:lts-alpine as vue_base

# Get certs
USER root
RUN mkdir -p /usr/local/share/ca-certificates
COPY --from=tools_download_basic /local_tools/certificate_layer /usr/local/share/ca-certificates
# Set certs
RUN npm config set cafile /usr/local/share/ca-certificates/Certificate_chain_base64.cer
# npm ERR! network request to https://registry.npmjs.org/ failed, reason: socket hang up
# npm ERR! network In most cases you are behind a proxy or have bad network settings.
RUN npm config set registry http://registry.npmjs.org/

# install vue
RUN npm install -g @vue/cli

# install and build
FROM vue_base as build_base
# create content in /app
WORKDIR /app
# copy in package files. we do this first to keep this layer more stable
COPY vue_service/src/package.json ./
# Install packages
RUN npm install
# copy in all source files
COPY vue_service/src .
# perform the build
RUN npm run build

##############################################################################
# vue_service_dev
##############################################################################
FROM build_base as vue_service_dev
VOLUME /local
CMD [ "tail", "-f", "/dev/null" ]
##############################################################################

# Start from an nginx image
FROM nginx:1.18 as run_layer
USER root
# copy build content to serve
COPY --from=build_base /app/dist /usr/share/nginx/html
COPY vue_service/nginx.conf /etc/nginx/nginx.conf
RUN chown -R nginx /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]