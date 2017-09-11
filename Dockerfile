FROM node:8-slim
MAINTAINER "gavin zhou" <gavin.zhou@gmail.com>

ENV PUPPETEER_VERSION=0.10.2

ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /tmp/noto

RUN set -ex && \
  apt-get update && \
  apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
  libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
  libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget unzip && \
  yarn global add puppeteer@${PUPPETEER_VERSION} && yarn cache clean && \
  mkdir -p /usr/share/fonts/noto && \
  cd /tmp/noto && unzip NotoSansCJKjp-hinted.zip && cp *.otf /usr/share/fonts/noto && \
  chmod 644 -R /usr/share/fonts/noto/ && \
  /usr/bin/fc-cache -fv && rm -rf /tmp/noto && \
  apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV NODE_PATH="/usr/local/share/.config/yarn/global/node_modules:${NODE_PATH}"

WORKDIR /app

CMD ["node", "index.js"]