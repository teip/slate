FROM ruby:2.6-slim as builder

WORKDIR /srv/slate

EXPOSE 4567

COPY Gemfile .
COPY Gemfile.lock .

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        nodejs \
    && gem install bundler \
    && bundle install \
    && apt-get remove -y build-essential git \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY . /srv/slate

RUN chmod +x /srv/slate/slate.sh
RUN /srv/slate/slate.sh build

# ENTRYPOINT ["/srv/slate/slate.sh"]
# CMD ["build"]

FROM nginx:1.13.12-alpine as production-stage
COPY --from=builder /srv/slate/build /usr/share/nginx/html
COPY --from=builder /srv/slate/deploy/nginx/server.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]