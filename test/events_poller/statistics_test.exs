defmodule EventsPoller.StatisticsTest do
  use ExUnit.Case

  alias EventsPoller.{Statistics, EventsDatabase}

  describe "capture/0" do
    setup do
      EventsDatabase.insert_event(%{"id" => 1})
      EventsDatabase.insert_event(%{"id" => 3})
      EventsDatabase.insert_event(%{"id" => 2})
    end

    test "returns a %Statistics{}" do
      assert %Statistics{} = Statistics.capture()
    end

    test "provides correct num_of_events" do
      assert %{num_of_events: 3} = Statistics.capture()
    end
  end
  
end
