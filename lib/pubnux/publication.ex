defmodule PubNux.Publication do
  @moduledoc """
  Publish messages to the provided channel

  It must receieve a Config structure in the following way

  payload =
    Config.build()
    |> Publication.set_channel("channel_name")
    |> Publication.set_time_token("time_token")
    |> Publication.set_callback("callback")

  Client.perform_request(payload)
  """
  alias PubNux.Config
  alias PubNux.Client

  @spec publish(Config.t, String.t, String.t) ::
  {:ok, Config.http_response() | Config.async_http_response()} | {:error, Config.http_error_response()}
  def publish(%Config{} = config, channel, message) do
    Client.call_service(config, channel, Poison.encode!(message), :publish)
  end
end
