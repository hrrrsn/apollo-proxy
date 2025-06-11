FROM node:22.16.0-slim@sha256:b1de8efb27062d48cfdfd666d812ef196ee53d8dc85c87ef95060fe94f6f5d47
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
