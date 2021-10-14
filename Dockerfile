#
# NodeJS 10.16 Build Image
# Docker image with libraries and tools as required for building NodeJS 10.16 projects using Yarn 
#

FROM cimg/node:14.18.0
LABEL Description="Docker image with libraries and tools as required for building NodeJS 10.16 projects using Yarn" Vendor="Agile Digital" Version="0.1"

# Add AdoptOpenJDK, borrowed from https://github.com/AdoptOpenJDK/openjdk-docker/blob/master/11/jdk/alpine/Dockerfile.hotspot.releases.full
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV HOME /home/jenkins
RUN sudo addgroup --system --gid 1000 jenkins
RUN sudo adduser --system --uid 1000 --home $HOME --ingroup jenkins jenkins
RUN sudo apt-get update && sudo apt-get install openjdk-8-jdk \
    && sudo apt-get install -y --no-install-recommends --no-upgrade \
        fonts-liberation \
        libappindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatspi2.0-0 \
        libcairo2 \
        libcups2 \
        libgbm1 \
        libgdk-pixbuf2.0-0 \
        libgtk-3-0 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libxcursor1 \
        libxss1 \
        xdg-utils \
        xvfb \
    && sudo rm -rf /var/lib/apt/lists/* \
    && npm i -g puppeteer

ENV CHROME_BIN=/usr/bin/chromium-browser

WORKDIR /home/jenkins
USER jenkins
