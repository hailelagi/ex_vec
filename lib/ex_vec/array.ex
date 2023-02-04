defmodule ExVec.Array do
  @moduledoc """
    Provides a simplified api to the std :erlang:array() which
    provides an an array data structure in pure erlang as a
    tree of tupled elements
  """
  def new(args) do
    # todo: unpack stream support?
    :array.new(args)
  end
end
