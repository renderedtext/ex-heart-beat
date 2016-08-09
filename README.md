# ExHeartbeat
Generates StatsD timer metric containing number of seconds since application start.

## Installation

  1. Add ex_heartbeat to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_heartbeat, github: "renderedtext/ex-heartbeat", ref: "origin/master"}]
        end

  2. Ensure ex_heartbeat is started before your application:

        def application do
          [applications: [:ex_heartbeat]]
        end

## Output
ExHeartbeat works without any configuration.

* It will emit metric to StatsD on localhost, port 8125.
* Default metric bucket name is `ex_heart_beat.ticker.i_am_alive`.
* By default metric is emitted every minute.

## Configuration
No configuration is required for this service.

Thought not necessary, it is recommended to explicitly configure
ExStatsD in order to set metric prefix there (key is 'namespace'):
```
config :ex_statsd,
       host: "localhost",
       port: 8125,
       namespace: "your_app_name.application_environment"
```

The rest of the configuration options are needed rarely.

Metric bucket name can be set with:
```
config(:ex_heartbeat, bucket_name: "custom_bucket_name")
```
and heartbeat pulse with:
```
config(:ex_heartbeat, pulse_ms: 1_000)  # emit every second
```

## Generated metrics
Q: I don't care how long my servers are running, I just want to know how many of them are there!

A: Timer metric also generates `...i_am_alive.count` which can be used to determine number of processes running the application.
