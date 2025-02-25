FROM node:22.14.0-slim@sha256:6bba748696297138f802735367bc78fea5cfe3b85019c74d2a930bc6c6b2fac4
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
