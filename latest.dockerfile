FROM registry.gitlab.com/tozd/docker/php:8.3

ARG BAIKAL_VERSION=0.13.0
ARG BAIKAL_SHA256=81e74df123230e863f608d228fdd7b9a1a788f60b04d37e6973c302192e83f32

VOLUME /var/lib/baikal

# We install the upstream release because distribution packages lag behind Baikal releases.
RUN apt-get update -q -q && \
  apt-get install wget unzip php8.3-curl php8.3-mbstring php8.3-sqlite3 php8.3-xml --yes --force-yes && \
  wget -q -O /tmp/baikal.zip "https://github.com/sabre-io/Baikal/releases/download/${BAIKAL_VERSION}/baikal-${BAIKAL_VERSION}.zip" && \
  echo "${BAIKAL_SHA256}  /tmp/baikal.zip" | sha256sum -c - && \
  unzip -q /tmp/baikal.zip -d /tmp/baikal && \
  mv /tmp/baikal/baikal /usr/share/baikal && \
  rm -rf /usr/share/baikal/config /usr/share/baikal/Specific && \
  ln -s /var/lib/baikal/config /usr/share/baikal/config && \
  ln -s /var/lib/baikal/Specific /usr/share/baikal/Specific && \
  mkdir -p /var/www && \
  ln -s /usr/share/baikal/html /var/www/baikal && \
  for file in /etc/php/8.3/mods-available/*.ini; do phpenmod $(basename -s .ini "$file"); done && \
  apt-get purge --yes --force-yes --auto-remove wget unzip && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
