defmodule EventsPoller.Config do
  defstruct [:url]

  def new(%{url: url}) do
    %__MODULE__{url: url}
  end

  def valid?(%__MODULE__{} = config) do
    valid_url?(config)
  end

  defp valid_url?(%{url: "http" <> _url}), do: true
  defp valid_url?(_), do: false
end
