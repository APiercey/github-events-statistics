defmodule EventsPoller.PipelineTest do
  use ExUnit.Case, async: false

  alias EventsPoller.{Pipeline, StatisticAgent, Statistics}

  setup_all do
    {:ok, _pid} = StatisticAgent.start_link(%Statistics{})
    :ok
  end

  describe "assemble/1" do
    test "provides a state" do
      result = (1..100_000)
      |> Flow.from_enumerable()
      |> Pipeline.assemble 
      |> Flow.run
    
    assert %Statistics{num_of_events: 100_000} = StatisticAgent.get()
    end
  end
end
