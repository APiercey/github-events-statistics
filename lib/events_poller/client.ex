defmodule EventsPoller.Client do
  alias EventsPoller.Config

  def create_config() do
    with url <- Application.fetch_env!(:gh_events, :url) do
      Config.new(%{url: url})
    end
  end

  def poll(%Config{url: "http://does_not_exist"}) do
    {:error, "error"}
  end

  def poll(%Config{url: url}) do
    events = 1..100 |> Enum.map(fn id -> %{"id" => id, "payload" => %{"test" => "hello"}} end)
    {:ok, events}
  end
end
