defmodule EventsPoller.Pipeline do
  use Flow

  alias EventsPoller.StatisticAgent

  def start_link(producers) do
    producers
    |> Flow.from_specs()
    |> assemble
    |> Flow.start_link()
  end

  def assemble(%Flow{} = flow) do
    flow
    |> Flow.each(fn _ -> 
      StatisticAgent.add(:num_of_events, 1)
    end)
  end
end
