defmodule ExVecTest do
  use ExUnit.Case
  doctest ExVec

  setup do
    %{
      vec: ExVec.Vector.new([42, 2, 3]),
      array: ExVec.Array.new([42, 2, 3])
    }
  end

  test "it makes a new vector wrapper" do
    vec_result = %ExVec.Vector{fields: [42, 2, 3], size: 3}
    assert vec_result == ExVec.Vector.new([42, 2, 3])

    array_result = ExVec.Array.new([42, 2, 3])
    assert :array.to_list(array_result.fields) == [42, 2, 3]
    assert array_result.size == 3
  end

  test "it checks for membership", ctx do
    assert true == Enum.member?(ctx.vec, 2)
    assert false == Enum.member?(ctx.vec, 8)
    assert true == 42 in ctx.vec

    assert true == Enum.member?(ctx.array, 2)
    assert false == Enum.member?(ctx.array, 8)
    assert true == 42 in ctx.array
  end

  test "it implements common access patterns", ctx do
    assert ctx.vec[0] == 42
    assert ctx.vec[7] == nil

    assert {42, %ExVec.Vector{fields: [2, 3], size: 2}} == ExVec.Vector.pop(ctx.vec, 0)

    assert {2, %ExVec.Vector{fields: [42, 3], size: 2}} ==
             ExVec.Vector.get_and_update(ctx.vec, 1, fn _ -> :pop end)

    assert {42, %ExVec.Vector{fields: [1, 2, 3], size: 3}} ==
             ExVec.Vector.get_and_update(ctx.vec, 0, fn n -> {n, 1} end)
  end

  test "it implements the 'reduce' pattern", ctx do
    assert [84, 4, 6] == Enum.map(ctx.vec, fn n -> n * 2 end)
    # assert [84, 4, 6] == Enum.map(ctx.array, fn n -> n * 2 end)
  end
end
