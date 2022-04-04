defmodule FungusTest do
  use ExUnit.Case
  doctest Fungus

  test "greets the world" do
    assert Fungus.hello() == :world
  end
end
