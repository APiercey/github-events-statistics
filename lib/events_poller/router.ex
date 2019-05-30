defmodule EventsPoller.Router do
  use Plug.Router
  
  plug(:match)
  plug(:dispatch)

  get("/hcheck", do: send_resp(conn, 200, "200 OK"))
  get("/favicon.ico", do: send_resp(conn, 200, ""))

  get "/statistics" do
    count = EventsPoller.Database.all()
    |> case do
      {:ok, result} -> result
    end
    |> Enum.count

    data = %{num_of_events: count, num_of_repos: 10}
    |> prepare_response
    |> Poison.encode!

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end

  defp prepare_response(data), do: %{data: data}
end
