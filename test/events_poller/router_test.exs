defmodule RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias EventsPoller.{Router, EventsDatabase}

  describe "GET [200] /statistics" do
    test "returns number of events" do
      EventsDatabase.insert_event(%{"id" => "id"})
      EventsDatabase.insert_event(%{"id" => "id"})
      assert %{num_events: 2} = get()
    end

    test "provides correct number of events over time" do
      EventsDatabase.insert_event(%{"id" => "id"})
      assert %{num_events: 1} = get()

      EventsDatabase.insert_event(%{"id" => "id"})
      EventsDatabase.insert_event(%{"id" => "id"})
      assert %{num_events: 3} = get()
    end

    defp get() do
      :get
      |> conn("/statistics", "")
      |> Router.call(%{})
      |> pluck_body
      |> Poison.decode!()
      |> pluck_data
    end

    defp pluck_body(%Plug.Conn{resp_body: body} = data), do: body
    defp pluck_data(%{"data" => data}), do: data
  end
end
