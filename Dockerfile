FROM node:22.13.1-slim@sha256:13b326848fbcfb58e5573e0904fc495967c7d8a9b0007cd95faed0508d164b54
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
