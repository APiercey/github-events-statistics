defmodule EventsPoller.DatabaseTest do
  use GhEvents.DataCase

  alias EventsPoller.{Database, GhEvent}

  describe "insert/1" do
    test "successfully adds an events" do
      data = %{type: "Repo.Created"}

      assert :ok = {"gh9uh", data} |> Database.insert()
    end
  end

  describe "all/0" do
    test "returns {:ok, []}" do
      assert {:ok, []} = Database.all()
    end

    test "return correct events" do
      {id, data} = expected = {"hh87as", %{type: "Repo.Updated"}}

      :ok = expected |> Database.insert

      assert {:ok, [{Event, ^id, ^data}]} = Database.all()
    end
  end
end
