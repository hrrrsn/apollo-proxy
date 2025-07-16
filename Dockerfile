FROM node:22.17.1-slim@sha256:618c6a5e14bbf0ad9706aa58263707c34cd64d306fda9e0397cb87e19bc3257a
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
