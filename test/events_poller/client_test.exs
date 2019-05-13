defmodule EventsPoller.ClientTest do
  use ExUnit.Case

  alias EventsPoller.{Client, Config}

  describe "create_config/0" do
    test "creates a valid config" do
      assert Client.create_config() |> Config.valid?()
    end

    test "creates a config from env vars" do
      expected = "http://events"
      Mix.Config.persist(gh_events: [url: expected])

      assert %{url: ^expected} = Client.create_config()
    end
  end

  describe "poll/1" do
    setup do
      %{config: Client.create_config()}
    end

    test "successful polls returns {:ok, _payload}", %{config: config} do
      assert {:ok, _} = config |> Client.poll()
    end

    test "payload is a collection", %{config: config} do
      {:ok, payload} = config |> Client.poll()

      assert payload |> is_list
    end

    test "each event has an ID", %{config: config} do
      {:ok, payload} = config |> Client.poll()

      assert payload
             |> List.first()
             |> Map.has_key?("id")
    end

    test "each event has an payload", %{config: config} do
      {:ok, payload} = config |> Client.poll()

      assert payload
             |> List.first()
             |> Map.has_key?("payload")
    end

    test "failed polls returns {:error, _internal_error}", %{config: config} do
      assert {:error, _reason} =
               config
               |> Map.put(:url, "http://does_not_exist")
               |> Client.poll()
    end
  end
end
