defmodule AsyncCalcTest do
  use ExUnit.Case
  doctest AsyncCalc

  test "greets the world" do
    assert AsyncCalc.hello() == :world
  end
end
