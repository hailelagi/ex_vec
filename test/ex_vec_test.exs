defmodule ExVecTest do
  use ExUnit.Case
  doctest ExVec

  test "it makes a new vector wrapper" do
    result = %ExVec.Vector{fields: [42, 2, 3], size: 3}

    assert {:ok, result} == ExVec.Vector.new([42, 2, 3])
  end

  test "it checks for memebership" do
    {:ok, vec} = ExVec.Vector.new([42, 2, 3])

    assert true == Enum.member?(vec, 2)
    assert false == Enum.member?(vec, 8)

    assert true == 42 in vec
  end

  test "it implements common access patterns" do
    {:ok, vec} = ExVec.Vector.new([42, 2, 3])

    assert vec[0] == 42
    assert vec[7] == nil
  end
end
