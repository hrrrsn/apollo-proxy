FROM node:22.13.0-slim@sha256:1264cf5b74c171fbd6af6f15027e224c0819c3338585dad37011efc395c6b7fc
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
