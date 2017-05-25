defmodule PubNux do
  @moduledoc """
  Documentation for PubNux.
  """
  alias PubNux.{Client, Subscription, Publication}

  @spec subscribe(String.t, String.t, String.t) ::
    {:ok, Client.http_response() | Client.async_http_response()} | {:error, Client.http_error_response()}
  def subscribe(channel_name, time_token \\ "0", callback \\ "defaultCallback") do
    Config.build()
    |> Subscription.build()
    |> Subscription.set_channel(channel_name)
    |> Subscription.set_time_token(time_token)
    |> Subscription.set_callback(callback)
    |> Client.perform_request()
  end
end
