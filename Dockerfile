FROM node:22.15.0-slim@sha256:39223e81d93967293dbb555da2b015e73241f9fdd229f7a3ae80b8ece65e432b
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
