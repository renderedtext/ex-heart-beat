defmodule ExHeartbeat do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ExHeartbeat.Ticker, [])
    ]

    opts = [strategy: :one_for_one, name: ExHeartbeat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule ExHeartbeat.Ticker do
  require Logger

  @pulse_ms 60_000
  @bucket_name "ex_heart_beat.ticker.i_am_alive"

  def start_link do
    pulse_ms    = Application.get_env(:ex_heartbeat, :pulse_ms)    || @pulse_ms
    bucket_name = Application.get_env(:ex_heartbeat, :bucket_name) || @bucket_name
    Logger.info("ExHeartbeat.Ticker bucket_name: #{inspect bucket_name}")
    Logger.info("ExHeartbeat.Ticker pulse_ms: #{inspect pulse_ms}")
    Task.start(fn -> i_am_alive(bucket_name, pulse_ms, now) end)
  end

  def i_am_alive(bucket_name, pulse_ms, start_time) do
    now() - start_time |> ExStatsD.timer(bucket_name)

    :timer.sleep(pulse_ms)
    i_am_alive(bucket_name, pulse_ms, start_time)
  end

  defp now, do:
    :calendar.datetime_to_gregorian_seconds(:calendar.universal_time)
end
