FROM node:22.14.0-slim@sha256:0eadf8714af515533a774407ddbc029f3ddb4b7984889dcc784fa12a1c134d91
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
