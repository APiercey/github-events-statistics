defmodule ApiTest do
  use ExUnit.Case, async: false

  @statistics_endpoint "http://localhost:4000/statistics"

  describe "[GET] 200 /statistics" do
    test "returns status 200" do
      assert %{status_code: 200} = HTTPoison.get!(@statistics_endpoint)
    end

    test "returns a application/json body" do
      assert HTTPoison.get!(@statistics_endpoint)
             |> parse_headers()
             |> Map.fetch!("content-type")
             |> String.contains?("application/json")
    end

    test "uses nested data" do
      assert %{"data" => _} = HTTPoison.get!(@statistics_endpoint) |> parse_body()
    end

    test "provides number of repos" do
      assert %{"num_of_repos" => _} 
      = HTTPoison.get!(@statistics_endpoint) |> parse_body() |> pluck_data()
    end

    test "provides number of events" do
      assert %{"num_of_events" => _} 
      = HTTPoison.get!(@statistics_endpoint) |> parse_body() |> pluck_data()
    end

    defp pluck_data(%{"data" => data}), do: data
    defp parse_body(%HTTPoison.Response{body: body}), do: body |> Poison.decode!()
    defp parse_headers(%HTTPoison.Response{headers: headers}), do: headers |> Enum.into(%{})
  end

  describe "[GET] 200 /hcheck" do
    test "The API is healthy" do
      assert %{status_code: 200} = HTTPoison.get!("http://localhost:4000/hcheck")
    end
  end
end
