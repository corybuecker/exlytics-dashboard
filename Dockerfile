FROM node:14-alpine as frontend-builder

ENV MIX_HOME /dashboard
COPY assets/package.json assets/package-lock.json $MIX_HOME/assets/
WORKDIR $MIX_HOME/assets

RUN npm install
COPY assets $MIX_HOME/assets
RUN npm run deploy

FROM elixir:1.10.3-alpine AS backend-builder
ARG mix_env=prod

ENV MIX_HOME /dashboard
ENV MIX_ENV $mix_env

WORKDIR $MIX_HOME
COPY mix.exs mix.lock $MIX_HOME/

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

COPY . $MIX_HOME
COPY --from=frontend-builder $MIX_HOME/priv/static $MIX_HOME/priv/static
RUN mix release

FROM elixir:1.10.3-alpine
ARG release=/dashboard/_build/prod/rel/dashboard
COPY --from=backend-builder $release /dashboard
CMD ["/dashboard/bin/dashboard", "start"]
