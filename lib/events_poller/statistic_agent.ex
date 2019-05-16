defmodule EventsPoller.StatisticAgent do
  use Agent

  alias EventsPoller.Statistics

  def start_link(init_state) do
		case	Agent.start_link(fn -> init_state end, name: __MODULE__) do
      {:error, {:already_started, pid}} -> {:ok, pid}
			other -> other
		end
  end

  def record(%Statistics{} = statistic) do
    Agent.update(__MODULE__, fn _ -> statistic end)
  end

  def add(:num_of_events, num) do
    Agent.update(__MODULE__, 
      fn statistic -> %Statistics{statistic | 
        num_of_events: statistic.num_of_events + num
      } end)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end
end
