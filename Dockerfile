FROM node:22.17.1-slim@sha256:c26e3d817a783016e1927a576b12bb262ebdaa9a4338e11ed2f7b31d557289b5
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
