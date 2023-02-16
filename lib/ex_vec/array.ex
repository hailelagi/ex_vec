defmodule ExVec.Array do
  @moduledoc """
    Provides a simplified api to the std :erlang:array() which
    provides an an array data structure in pure erlang as a
    tree of tupled elements
  """

  @behaviour Access
  alias ExVec.Array

  @type t :: %__MODULE__{
          fields: list(),
          size: pos_integer()
        }

  defstruct fields: nil, size: 0

  def new(args) do
    new = :array.new()

    {size, fields} =
      Enum.reduce(args, {0, new}, fn n, {i, acc} ->
        {i + 1, :array.set(i, n, acc)}
      end)

    %__MODULE__{
      fields: fields,
      size: size
    }
  end

  defimpl Enumerable, for: ExVec.Array do
    def count(%Array{fields: fields} = _vec), do: {:ok, :array.size(fields)}

    def member?(%Array{fields: fields}, key) do
      ord = :array.sparse_to_orddict(fields)
      membership = Enum.any?(ord, fn {_i, value} -> value == key end)

      {:ok, membership}
    end

    def reduce(_list, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce(vec, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vec.fields, &1, fun)}
    def reduce([], {:cont, acc}, _fun), do: {:done, acc}

    def reduce(%Array{fields: fields}, {:cont, acc}, fun) do
      :array.foldl(fn _index, val, acc -> fun.(val, acc) end, acc, fields)
    end
  end

  @impl Access
  def fetch(%Array{fields: fields, size: size}, index) do
    cond do
      index > 0 and index <= size -> {:ok, :array.get(index, fields)}
      index < 0 -> :error
      true -> :error
    end
  end
end
