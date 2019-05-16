defmodule ApiTest do
  use GhEvents.ApiAcceptanceCase, async: false

  @statistics_endpoint "http://localhost:4000/statistics"

  describe "[GET] 200 /statistics" do
    test "returns status 200" do
      assert %{status_code: 200} = get!(@statistics_endpoint)
    end

    test "returns a application/json body" do
      assert get!(@statistics_endpoint)
             |> parse_headers()
             |> Map.fetch!("content-type")
             |> String.contains?("application/json")
    end

    test "uses nested data" do
      assert %{"data" => _} = get!(@statistics_endpoint) |> parse_body()
    end

    test "provides number of repos" do
      assert %{"num_of_repos" => _} 
      = get!(@statistics_endpoint) |> parse_body() |> pluck_data()
    end

    test "provides number of events" do
      assert %{"num_of_events" => _} 
      = get!(@statistics_endpoint) |> parse_body() |> pluck_data()
    end

  end

  describe "[GET] 200 /hcheck" do
    test "The API is healthy" do
      assert %{status_code: 200} = get!("http://localhost:4000/hcheck")
    end
  end
end
