FROM node:22.8.0-slim@sha256:377674fd5bb6fc2a5a1ec4e0462c4bfd4cee1c51f705bbf4bda0ec2c9a73af72
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
