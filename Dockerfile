FROM node:22.14.0-slim@sha256:0477b569943edd0f0aa24e7881a4d9cba8c23e860802a6b64bc4f4485240af11
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
