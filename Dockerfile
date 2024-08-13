FROM node:22.6.0-slim@sha256:48478c8e861b206fdc26914705dd6ab777571dd213755e91f80c3f3abafd0d5e
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
