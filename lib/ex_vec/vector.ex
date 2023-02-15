defmodule ExVec.Vector do
  @moduledoc """
    elixir wrapper for std::vec::Vec<T, A>
    stores values in a custom key-value map, where:
    keys are indices starting from 0 and values are passed to new/1
  """
  use Rustler, otp_app: :ex_vec, crate: "exvec_vector"

  alias ExVec.Vector

  @type t :: %__MODULE__{
          fields: list(),
          size: pos_integer()
        }

  defstruct fields: nil, size: 0

  @behaviour Access

  def new(args) when is_struct(args), do: init(Enum.to_list(args))
  def new(args) when is_list(args), do: init(args)
  def new(_args), do: :error

  # Natively Implemented in Rust
  def init(_args), do: error()
  def member(_, _), do: error()
  def get(_, _), do: error()
  def slice(_, _), do: error()
  def update(_data, _key, _function), do: error()
  def delete(_data, _key), do: error()

  defimpl Enumerable, for: ExVec.Vector do
    def count(%Vector{size: size} = _vec), do: {:ok, size}

    def member?(%Vector{} = v, key), do: Vector.member(v, key)

    # this is cheating but oh well, it's faster than the roundtrip anyway and
    # they're both O(n) operations
    def reduce(_list, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce(vec, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(vec.fields, &1, fun)}
    def reduce([], {:cont, acc}, _fun), do: {:done, acc}
    def reduce([head | tail], {:cont, acc}, fun), do: reduce(tail, fun.(head, acc), fun)

    def reduce(%Vector{fields: [head | tail]}, {:cont, acc}, fun) do
      reduce(tail, fun.(head, acc), fun)
    end

    def slice(%Vector{}) do
      nil
    end
  end

  @impl Access
  def fetch(%Vector{} = vec, key) do
    case Vector.get(vec, key) do
      {:ok, value} -> {:ok, value}
      {:error, _} -> :error
    end
  end

  @impl Access
  def get_and_update(vec, key, function) do
    nil
  end

  @impl Access

  def pop(%Vector{} = vec, key) do
    case Vector.delete(vec, key) do
      {:ok, value} -> {:ok, value}
      {:error, _} -> :error
    end
  end
  def error, do: :erlang.nif_error(:nif_not_loaded)
end
