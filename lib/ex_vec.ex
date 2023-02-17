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

  MyApp.print_to_64()
  """

  defmacro __using__(implementation: impl) do
    quote do
      import unquote(__MODULE__)
      Module.put_attribute(__MODULE__, :implementation, unquote(impl))
    end
  end

  defmacro vec!([_h | _t] = args) do
    quote bind_quoted: [args: args] do
      dispatch_constructor(@implementation, args)
    end
  end

  defmacro vec!({:.., _, [first, last]}) do
    args = Range.new(first, last) |> Enum.to_list()

    quote bind_quoted: [args: args] do
      dispatch_constructor(@implementation, args)
    end
  end

  def dispatch_constructor(impl, args) do
    case impl do
      :rust -> Vector.new(args)
      :erlang -> Array.new(args)
      _ -> raise "invalid constructor type, did you mean :rust?"
    end
  end
end
