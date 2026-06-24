FROM node:24.17.0-slim@sha256:964191e9c047c5ababb0ba8a6e613cc70714a1de1fbca57e717c516f689c8053
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN rm -rf /app/certificates/* /app/test/ /app/old/

ENV WEB_SERVER_PORT=8080
ENV PROXY_PORT=8443

EXPOSE 8080
EXPOSE 8443

CMD [ "node", "apollo-proxy.js" ]
