defmodule EventsPoller.StatisticAgentTest do
  use ExUnit.Case, async: false

  alias EventsPoller.{StatisticAgent, Statistics}

  describe "record/1" do
    setup do
      {:ok, _pid} = StatisticAgent.start_link(%Statistics{})
      :ok
    end

    test "records a %Statistics{}" do
      assert :ok = StatisticAgent.record(%Statistics{})
    end
  end


  describe "get/0" do
    setup do
      {:ok, _pid} = StatisticAgent.start_link(%Statistics{})
      :ok
    end

    test "returns a %Statistics{}" do
      assert %Statistics{} = StatisticAgent.get()
    end
  end
end
