defmodule ExVec do
  @moduledoc """
    ExVec is a tiny library illustrating how macros can be used provide
    ergonomic access to the constructor pattern.
  """
  alias ExVec.{Array, Vector}

  @doc ~S"""
  vec! is a macro that takes an arbitrary number of arguments or a
  stream and produces a dynamic array with fast random read/write access.

  ## Examples
  defmodule MyApp do
    use ExVec, implementation: :rust

    def print_to_64 do
      for i <- vec!(0..64) do
        IO.puts(i)
      end
    end
  end
  """
  defmacro vec!(arguments, do: expression) do
    quote do
      Array.new(arguments)
    end
  end
end
