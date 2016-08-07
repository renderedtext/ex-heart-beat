# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config(:ex_heartbeat, bucket_name: "foo.bar")
config(:ex_heartbeat, pulse_ms: 1_000)

# ExStatsD
config :ex_statsd,
       host: "localhost",
       port: 8125,
       namespace: "ehb.test"
