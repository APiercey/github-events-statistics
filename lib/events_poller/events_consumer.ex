defmodule EventsPoller.EventsConsumer do
  use GenStage

  def start_link(_init_args) do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(_init_args) do
    {:consumer, 0}
  end

  def handle_events(events, _from, count) do
    number = (count + Enum.count(events)) |> IO.inspect()
    {:noreply, [], number}
  end
end
