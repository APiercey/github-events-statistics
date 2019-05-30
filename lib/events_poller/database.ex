defmodule EventsPoller.Database do
  alias :mnesia, as: Mnesia  

  def insert({id, %{type: _type} = data}) do
    fn ->
      Mnesia.write({Event, id, data})
    end
    |> Mnesia.transaction
    |> case do
      {:atomic, :ok} -> :ok
      error -> error
    end
  end

  def insert(_), do: {:error, :incorrect_format}

  def all() do
    fn ->
      Mnesia.match_object({Event, :_, :_})
    end
    |> Mnesia.transaction
    |> IO.inspect
    |> case do
      {:atomic, result} -> {:ok, result}
      error -> error
    end
  end
end
