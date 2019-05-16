defmodule HcheckTest do
  use GhEvents.ApiAcceptanceCase, async: false

  describe "[GET] 200 /hcheck" do
    test "The API is healthy" do
      assert %{status_code: 200} = get!("http://localhost:4000/hcheck")
    end
  end
end
