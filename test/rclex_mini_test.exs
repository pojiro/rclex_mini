defmodule RclexMiniTest do
  use ExUnit.Case
  doctest RclexMini

  test "greets the world" do
    assert RclexMini.hello() == :world
  end
end
