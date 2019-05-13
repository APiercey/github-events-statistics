defmodule RouterTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias EventsPoller.{Router, EventsDatabase, StatisticAgent, Statistics}

  setup_all do
    {:ok, _pid} = StatisticAgent.start_link(%Statistics{})
    :ok
  end

  describe "GET [200] /statistics" do
    test "returns number of events" do
      StatisticAgent.record(%Statistics{num_of_events: 20})
      assert %{"num_of_events" => 20} = get()
    end

    test "returns number of repos" do
      StatisticAgent.record(%Statistics{num_of_repos: 3})
      assert %{"num_of_repos" => 3} = get()
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
