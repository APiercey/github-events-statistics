defmodule GhEvents.DataCase do
 use ExUnit.CaseTemplate

  using do
    quote do
      import GhEvents.DataCase
    end
  end

  setup do
    :mnesia.clear_table(Event) |> IO.inspect
    :ok
  end
end
