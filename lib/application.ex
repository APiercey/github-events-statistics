defmodule GhEvents.Application do
  use Application

  alias EventsPoller.{Router, StatisticAgent, Statistics, Pipeline, EventsProducer}

  def start(_init, _args) do
    childern = [
      Plug.Cowboy.child_spec(scheme: :http, plug: EventsPoller.Router, options: [port: 4000]),
      {StatisticAgent, %Statistics{}},
      {Pipeline, [{EventsProducer, []}]}
    ]

    opts = [strategy: :one_for_one, name: Router]
    Supervisor.start_link(childern, opts)
  end
end
