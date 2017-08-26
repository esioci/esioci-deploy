FROM elixir:1.4.5

#RUN mkdir -p /opt/esioci

RUN apt-get update && apt-get -y install unzip
RUN cd /opt && wget https://github.com/esioci/esioci/archive/master.zip && unzip master.zip
WORKDIR /opt/esioci-master

RUN mix local.hex --force && mix local.rebar --force && mix deps.get && mix compile

EXPOSE 4000

ENTRYPOINT mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs && mix run --no-halt
