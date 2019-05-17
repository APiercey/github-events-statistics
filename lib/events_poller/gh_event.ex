defmodule EventsPoller.GhEvent do
  @fields ~w(id type)a
  @enforce_keys @fields
  defstruct @fields
end
