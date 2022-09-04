defmodule PhoenixLiveDebugConsoleTest do
  use ExUnit.Case
  doctest PhoenixLiveDebugConsole

  test "greets the world" do
    assert PhoenixLiveDebugConsole.hello() == :world
  end
end
