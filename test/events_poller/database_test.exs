defmodule EventsPoller.DatabaseTest do
  use GhEvents.DataCase

  alias EventsPoller.{Database, GhEvent}

  describe "insert/1" do
    test "successfully adds an events" do
      assert {:ok, %{id: "gh9uh", type: "Repo.Created"}} 
        = %{id: "gh9uh", type: "Repo.Created"} |> Database.insert()
    end
  end

  describe "all/0" do
    test "returns {:ok, []}" do
      assert {:ok, []} = Database.all()
    end

    test "return correct events" do
      expected = %{id: "hh87as", type: "Repo.Updated"}
      {:ok, _} = expected |> Database.insert

      assert {:ok, [^expected]} = Database.all()
    end
  end
end
