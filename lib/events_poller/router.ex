defmodule EventsPoller.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get("/hcheck", do: send_resp(conn, 200, "200 OK"))
  get("/favicon", do: send_resp(conn, 200, ""))

  get "/statistics" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{data: %{num_of_repos: 0, num_of_events: 3}}))
  end
end
