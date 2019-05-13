defmodule GhEvents.Application do
  use Application

  def start(_init, _args) do
    childern = [
      Plug.Cowboy.child_spec(scheme: :http, plug: EventsPoller.Router, options: [port: 4000])
    ]

    opts = [strategy: :one_for_one, name: Router]
    Supervisor.start_link(childern, opts)
  end
end
