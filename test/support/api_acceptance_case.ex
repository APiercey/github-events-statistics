defmodule GhEvents.ApiAcceptanceCase do
 use ExUnit.CaseTemplate

  using do
    quote do
      import GhEvents.ApiAcceptanceCase
      import HTTPoison
    end
  end

  setup_all do
    :ok = Application.start(:gh_events)
    :ok
  end

  def pluck_data(%{"data" => data}), do: data
  def parse_body(%HTTPoison.Response{body: body}), do: body |> Poison.decode!()
  def parse_headers(%HTTPoison.Response{headers: headers}), do: headers |> Enum.into(%{})
end
