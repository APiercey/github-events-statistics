defmodule EventsPoller.Pipeline do
  use Flow

  def start_link(producers) do
    producers
    |> Flow.start_link()
  end
end
