FROM node:4.8.7-slim

RUN apt-get update && \
  apt-get install -y \
  g++ \
  libzmq3-dev \
  libzmq3-dbg \
  libzmq3 \
  make \
  python \
  gettext-base \
  jq \
  patch \
  && \
  wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
  dpkg -i dumb-init_*.deb

EXPOSE 3001 9333 19335

WORKDIR /root/litecoin-node
COPY litecore-node ./
RUN npm config set package-lock false && \
  npm install && \
  cat logo_insight_litecoin.patch | patch -p1 -d node_modules/insight-lite-ui

RUN apt-get purge -y \
  g++ make python gcc && \
  apt-get autoclean && \
  apt-get autoremove -y && \
  rm -rf \
  node_modules/litecore-node/test \
  node_modules/litecore-node/bin/litecoin-*/bin/litecoin-qt \
  node_modules/litecore-node/bin/litecoin-*/bin/test_litecoin \
  node_modules/litecore-node/bin/litecoin-*.tar.gz \
  /dumb-init_*.deb \
  /root/.npm \
  /root/.node-gyp \
  /tmp/* \
  /var/lib/apt/lists/*

ENV LITECOIN_LIVENET 0
ENV API_ROUTE_PREFIX "api"
ENV UI_ROUTE_PREFIX ""

ENV API_CACHE_ENABLE 1

ENV API_LIMIT_ENABLE 1
ENV API_LIMIT_WHITELIST "127.0.0.1 ::1"
ENV API_LIMIT_BLACKLIST ""

ENV API_LIMIT_COUNT 10800
ENV API_LIMIT_INTERVAL 10800000

ENV API_LIMIT_WHITELIST_COUNT 108000
ENV API_LIMIT_WHITELIST_INTERVAL 10800000

ENV API_LIMIT_BLACKLIST_COUNT 0
ENV API_LIMIT_BLACKLIST_INTERVAL 10800000

HEALTHCHECK --interval=5s --timeout=5s --retries=5 CMD curl -s "http://localhost:3001/{$API_ROUTE_PREFIX}/sync" | jq -r -e ".status==\"finished\""

ENTRYPOINT ["/usr/bin/dumb-init", "--", "./litecore-node-entrypoint.sh"]

VOLUME /root/litecoin-node/data
