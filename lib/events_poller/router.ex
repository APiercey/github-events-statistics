defmodule EventsPoller.Router do
  use Plug.Router

  alias EventsPoller.StatisticAgent

  plug(:match)
  plug(:dispatch)

  get("/hcheck", do: send_resp(conn, 200, "200 OK"))
  get("/favicon", do: send_resp(conn, 200, ""))

  get "/statistics" do
    data = StatisticAgent.get 
           |> prepare_response 
           |> Poison.encode!
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end

  defp prepare_response(data), do: %{data: data}
end
