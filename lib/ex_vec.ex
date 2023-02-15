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
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro vec!({_node, _, args}) do
    quote do
      case implementation do
        :rust -> Vector.new(unquote(args))
        :erlang -> Array.new(unquote(args))
        _ -> raise "invalid"
      end
    end
  end
end
