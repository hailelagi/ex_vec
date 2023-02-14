defmodule ExVec.Vector do
  @moduledoc """
    elixir wrapper for std::vec::Vec<T, A>
    stores values in a custom key-value map, where:
    keys are indices starting from 0 and values are passed to new/1
  """
  use Rustler, otp_app: :ex_vec, crate: "exvec_vector"

  alias ExVec.Vector

  defstruct fields: nil, size: 0

  @behaviour Access

  def new(_args), do: error()
  def member(_, _), do: error()
  def get(_, _), do: error()

  defimpl Enumerable, for: ExVec.Vector do
    def count(%Vector{size: size} = _vec), do: {:ok, size}
    def count(list) when is_list(list), do: {:ok, Vector.new(list).size}
    def member?(enum, key), do: Vector.member(enum, key)

    def reduce(_, _, _) do
      {:done, 0}
    end

    def slice(%Vector{size: size}) do
      {:ok, size, fn _, _ -> nil end}
    end
  end

  # defimpl Collectable, for: ExVec.Vector do
  #   def into(_) do
  #     nil
  #   end
  # end

  @impl Access
  def fetch(%Vector{} = vec, key) do
    case Vector.get(vec, key) do
      {:ok, value} -> {:ok, value}
      {:error, _} -> :error
    end
  end

  @impl Access
  def get_and_update(_data, _key, _function) do
    nil
  end

  @impl Access
  def pop(_data, _key) do
    nil
  end

  def error, do: :erlang.nif_error(:nif_not_loaded)
end
