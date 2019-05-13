defmodule EventsPoller.ConfigTest do
  use ExUnit.Case

  alias EventsPoller.Config

  @valid_params %{url: "https://api.github.com/events"}

  describe "new/1" do
    test "returns new %Config{}" do
      assert %Config{} = @valid_params |> Config.new()
    end
  end

  describe "validate/1" do
    setup do
      %{config: @valid_params |> Config.new()}
    end

    test "valid_params pass validation", %{config: config} do
      assert config |> Config.valid?()
    end

    test "invalid url fails", %{config: config} do
      refute config |> Map.put(:url, "hello") |> Config.valid?()
    end
  end
end
