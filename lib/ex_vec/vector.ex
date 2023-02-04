defmodule ExVec.Vector do
  @moduledoc """
    elixir wrapper for std::vec::Vec<T, A>
  """
  @behaviour Access

  defimpl Enumerable, for: ExVec.Array do
    def count(vec) do
      0
    end
  end

  defimpl Collectable, for: ExVec.Array do
  end

  @impl Access
  def new(args), do: args

  @impl Access
  def fetch(term, key) do
    nil
  end

  @impl Access
  def get_and_update(data, key, function) do
    nil
  end

  @impl Access
  def pop(data, key) do
    nil
  end
end
