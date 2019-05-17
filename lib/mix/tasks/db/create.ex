defmodule Mix.Tasks.Db.Create do
  @shortdoc """
  Create an :mnesia datastore
  """
  use Mix.Task

  alias :mnesia, as: Mnesia
  require Logger

  @impl Mix.Task
  def run(_) do
    home = node()
    [home]
    |> Mnesia.create_schema() 
    |> case do
      {:error, {^home, {:already_exists, ^home}}} -> "Database already created"
      :ok -> "Database created"
    end
    |> Logger.info
  end
end
