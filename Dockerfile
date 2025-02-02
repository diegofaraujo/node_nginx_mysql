FROM node:16

RUN apt-get update && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN npm install -g nodemon

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install

COPY . .

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ./docker-entrypoint.sh

EXPOSE 3000

#CMD ["node", "index.js"]