FROM node:22.11.0-slim@sha256:698d071bca40e6769277003a404a9e5e52f3ed98f6bd4bdbb3315100f22de72e
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
