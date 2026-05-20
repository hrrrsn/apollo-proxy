FROM node:24.15.0-slim@sha256:b809ce06df0b8f49f8a3015e23a38f47fabfa1052d4d6916655eaae0d9950ff9
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
