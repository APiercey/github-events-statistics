defmodule EventsPoller.Database do
  alias :mnesia, as: Mnesia  

  def insert(%{id: id, type: type}) do
    fn ->
      Mnesia.write({Event, id, type})
    end
    |> Mnesia.transaction
    |> case do
      {:atomic, :ok} -> {:ok, %{id: id, type: type}}
      error -> error
    end
  end

  def all() do
    fn ->
      Mnesia.read({Event})
    end
    |> Mnesia.transaction
    |> IO.inspect
    |> case do
      {:atomic, result} -> {:ok, result}
      error -> error
    end
    {:ok, []}
  end
end
