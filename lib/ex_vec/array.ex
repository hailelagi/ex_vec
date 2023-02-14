defmodule ExVec.Array do
  @moduledoc """
    Provides a simplified api to the std :erlang:array() which
    provides an an array data structure in pure erlang as a
    tree of tupled elements
  """

  @derive Access

  def new(args) do
    # todo: unpack stream support?
    :array.new(args)
  end

  defdelegate fetch(term, key), to: List
  defdelegate get(term, key, default), to: List
  defdelegate get_and_update(term, key, fun), to: List
  defdelegate pop(data, key), to: Tuple
end
