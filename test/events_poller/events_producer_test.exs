defmodule EventsPoller.EventsProducerTest do
  use ExUnit.Case

  alias EventsPoller.{EventsProducer}

  describe "handle_demand/2" do
    test "takes events from state if demand is satisfied" do
      state = create_state(10)
      {_, demand, %{events: remaining}} = EventsProducer.handle_demand(10, state)

      assert 10 = Enum.count(demand)
      assert 0 = Enum.count(remaining)
    end

    test "takes events from state and asks for more if demand is unsatisfied " do
      state = create_state(4)
      {_, demand, %{events: remaining}} = EventsProducer.handle_demand(10, state)

      assert 10 = Enum.count(demand)
      assert Enum.count(remaining) > 0
    end

    defp create_state(num_of_events),
      do: %{events: 1..num_of_events |> Enum.map(fn num -> num end)}
  end

  describe "stream/1" do
    setup do
      {:ok, pid} = EventsProducer.start_link([])
      %{pid: pid}
    end

    test "returns a collection of events", %{pid: pid} do
      [head_event | _tail_events] = GenStage.stream([{pid, max_demand: 1}]) |> Enum.take(1)

      assert %{"id" => _id, "payload" => _payload} = head_event
    end
  end
end
