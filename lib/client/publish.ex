defmodule PubNux.Client.Publish do
  @moduledoc """
  Publish messages to the provided channel
  """
  alias PubNux.Client
  alias PubNux.Client.Helpers

  @spec publish(Client.t, String.t, String.t) :: {:ok, any()} | {:error, any()}
  def publish(%Client{} = client, channel, message) do
    Helpers.call_service(client, channel, Poison.encode!(message))
  end
end
