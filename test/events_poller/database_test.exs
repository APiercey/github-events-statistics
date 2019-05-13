defmodule EventsPoller.EventsDatabaseTest do
  use ExUnit.Case

  alias :mnesia, as: Mnesia
  alias EventsPoller.EventsDatabase

  describe "insert_event/1" do
    test "inserts and returns result" do
      Mnesia.clear_table(Event)
      assert {:ok, _params} = EventsDatabase.insert_event(%{"id" => 1})
    end
  end

  describe "all/0" do
    setup do
      Mnesia.clear_table(Event)
      EventsDatabase.insert_event(%{"id" => 1})
      EventsDatabase.insert_event(%{"id" => 2})
    end

    test "returns a {:ok, _result}" do
      assert {:ok, _result} = EventsDatabase.all()
    end

    test "result is a collection" do
      {:ok, result} = EventsDatabase.all()

      assert result |> is_list
    end

  end
end
