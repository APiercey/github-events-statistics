defmodule EventsPoller.EventsProducer do
  use GenStage

  alias EventsPoller.Client

  def start_link(_init_args) do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(_init_args) do
    {:producer, %{events: []}}
  end

  def handle_info(msg, state) do
    IO.inspect(msg)
  end

  def handle_demand(demand, state) do
    events =
      if length(state.events) >= demand do
        state.events
      else
        state.events ++ fetch_events()
      end

    :timer.sleep(500)
    IO.inspect("demand!")

    {to_dispatch, remaining} = Enum.split(events, demand)

    {:noreply, to_dispatch, %{state | events: remaining}}
  end

  defp fetch_events() do
    with {:ok, payload} <- Client.create_config() |> Client.poll() do
      payload
    end
  end
end
