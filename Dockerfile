# Docker file to create production build meant to be deployed in nginx server
# MULTI stage docker file - build stage and run stage.
# specify base image
FROM node:16-alpine AS build-stage

# specify build dependencies
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .

RUN npm run build

#FROM keyword below denotes the start of a new (run) stage.
FROM nginx

# copy the build folder from build-stage phase into /usr/share/nginx/html folder within the container. 
# Placing the build files here /usr/share/nginx/html is nginx requirement.
COPY --from=build-stage /app/build /usr/share/nginx/html 

# no command needs to be specified as the default command of the nginx image is to start nginx server.
