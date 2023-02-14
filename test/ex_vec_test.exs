defmodule ExVecTest do
  use ExUnit.Case
  doctest ExVec

  test "greets the world" do
    result = %ExVec.Vector{fields: [42]}

    assert {:ok, result} == ExVec.Vector.echo(42)
  end
end
