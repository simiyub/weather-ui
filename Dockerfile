# Examples: https://gist.github.com/adamveld12/4815792fadf119ef41bd and https://docs.docker.com/engine/reference/builder/

FROM node:latest

RUN mkdir -p /app/src

WORKDIR /app/src

COPY package.json . 

RUN npm install

COPY . ./

RUN npm run build

FROM ngix:stable-alpine

COPY --from=build /app/build /usr/shar/ngix/html

EXPOSE 80

CMD ["ngix", "-g", "daemon off;"]
