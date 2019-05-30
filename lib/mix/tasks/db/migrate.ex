defmodule Mix.Tasks.Db.Migrate do
  @shortdoc """
  Migrate an :mnesia datastore
  """
  use Mix.Task

  alias :mnesia, as: Mnesia
  require Logger

  @impl Mix.Task

  def run(_) do
    with :ok = Mnesia.start(),
         :ok = migrate() do
      Logger.info("Database migrated successfully")
    end
  end

  defp migrate do
    case Mnesia.create_table(Event, [attributes: [:id, :data]]) do
      {:atomic, :ok} -> :ok
      {:aborted, {:already_exists, Event}} -> :ok
    end
  end
end
