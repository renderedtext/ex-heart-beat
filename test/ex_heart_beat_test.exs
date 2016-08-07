defmodule ExHeartbeatTest do
  use ExUnit.Case
  doctest ExHeartbeat

  @tag timeout: 1_000_000
  test "infinite test" do
    :timer.sleep :infinity
  end
end
