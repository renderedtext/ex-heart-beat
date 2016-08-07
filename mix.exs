defmodule ExHeartbeat.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_heartbeat,
     version: "0.1.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [ applications: [
        :logger,
        :ex_statsd,
      ],
      mod: {ExHeartbeat, []}
    ]
  end

  defp deps do
    [
      {:ex_statsd, ">= 0.5.1"},
    ]
  end
end
