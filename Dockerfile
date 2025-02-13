FROM node:22.14.0-slim@sha256:91be66fb4214c9449836550cf4c3524489816fcc29455bf42d968e8e87cfa5f2
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
