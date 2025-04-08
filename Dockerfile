FROM node:22.14.0-slim@sha256:373f9e53a753877bcbd21e6e7884682f6b1988ee63a4c4129e9051bb96546081
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
