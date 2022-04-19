FROM node:lts-alpine

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV MEMORY_CACHE=0

# install chromium, tini and clear cache
RUN apk add --no-cache chromium tini

USER node
WORKDIR "/home/node"

COPY ./package.json .
COPY ./server.js .

# install npm packages
RUN npm ci

EXPOSE 3000

ENTRYPOINT ["tini", "--"]
CMD ["node", "server.js"]
