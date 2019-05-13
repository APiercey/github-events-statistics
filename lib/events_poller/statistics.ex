defmodule EventsPoller.Statistics do
  defstruct [:num_of_events, :num_of_repos]

  def capture do
    %__MODULE__{num_of_events: 3}
  end
end
