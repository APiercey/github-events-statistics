defmodule EventsPoller.StatisticAgentTest do
  use ExUnit.Case, async: false

  alias EventsPoller.{StatisticAgent, Statistics}

  setup_all do
    {:ok, _pid} = StatisticAgent.start_link(%Statistics{})
    :ok
  end

  describe "record/1" do
    setup do
      StatisticAgent.record(%Statistics{})
    end

    test "records a %Statistics{}" do
      assert :ok = StatisticAgent.record(%Statistics{})
    end
  end

  describe "get/0" do
    test "returns a %Statistics{}" do
      assert %Statistics{} = StatisticAgent.get()
    end
  end

  describe "add/2" do
    setup do
      StatisticAgent.record(%Statistics{})
    end

    test "increases num_of_events" do
      %{num_of_events: 0} = StatisticAgent.get()
      StatisticAgent.add(:num_of_events, 5)
      assert %{num_of_events: 5} = StatisticAgent.get()
    end
  end
end
