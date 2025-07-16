FROM node:22.17.1-slim@sha256:8edd19bb0ba8fc100d260f1c8f2281fb215f60d9ce19c2476d48de47e6750405
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
