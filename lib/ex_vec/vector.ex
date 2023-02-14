defmodule ExVec.Vector do
  @moduledoc """
    elixir wrapper for std::vec::Vec<T, A>
    stores values in a custom key-value map, where:
    keys are indices starting from 0 and values are passed to new/1
  """
  use Rustler, otp_app: :ex_vec, crate: "exvec_vector"

  defstruct fields: %{}
  @behaviour Access

  def echo(_), do: error()

  def new(_args) do
    []
  end

  defimpl Enumerable, for: ExVec.Array do
    def count(_vec) do
      0
    end

    def member?(_, _) do
      false
    end

    def reduce(_, _, _) do
      nil
    end

    def slice(_) do
      nil
    end
  end

  defimpl Collectable, for: ExVec.Array do
    def into(_) do
      nil
    end
  end

  # todo: must define access via rust?
  # @impl Access
  # def fetch(_term, _key) do
  #   nil
  # end

  # @impl Access
  # def get_and_update(_data, _key, _function) do
  #   nil
  # end

  # @impl Access
  # def pop(_data, _key) do
  #   nil
  # end

  defdelegate fetch(term, key), to: Map
  defdelegate get(term, key, default), to: Map
  defdelegate get_and_update(term, key, fun), to: Map
  defdelegate pop(data, key), to: Map

  def error, do: :erlang.nif_error(:nif_not_loaded)
end
