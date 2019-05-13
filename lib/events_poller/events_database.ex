defmodule EventsPoller.EventsDatabase do
  alias :mnesia, as: Mnesia

  def init do
    Mnesia.create_schema([node()])
    :ok = Mnesia.start()
    migrate()
    :ok
  end

  def insert_event(%{"id" => id} = params) do
    {:atomic, :ok} = fn -> 
      Mnesia.write({Event, id, "repo"}) 
    end
    |> Mnesia.transaction()

    {:ok, params}
  end

  def all do
    {:ok, []}
  end

  defp migrate do
    case Mnesia.create_table(Event, attributes: [:id, :repo]) do
      {:atomic, :ok} -> :ok
      {:aborted, {:already_exists, Event}} -> :ok
    end 
  end
end
