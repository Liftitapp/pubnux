defmodule PubNux do
  @moduledoc """
    TODO: Write this docs
  """
  alias PubNux.{Config, Client, Subscription, Publication}

  @spec subscribe(String.t, String.t, String.t) ::
    {:ok, Client.http_response()} | {:error, Client.http_error_response() | Client.http_bad_request_response()}
  def subscribe(channel_name, time_token \\ "0", callback \\ "defaultCallback") do
    subs_params = [
      {:channel, channel_name},
      {:time_token, time_token},
      {:callback, callback}
    ]

    Config.build()
    |> Subscription.build(subs_params)
    |> Client.perform_request()
  end

  @spec publish(String.t, map(), String.t, String.t) ::
    {:ok, Client.http_response()} | {:error, Client.http_error_response() | Client.http_bad_request_response()}
  def publish(channel_name, message, callback \\ "defaultCallback", store \\ false) do
    pub_params = [
      {:channel, channel_name},
      {:message, Poison.encode!(message)},
      {:store, store},
      {:callback, callback}
    ]

    Config.build()
    |> Publication.build(pub_params)
    |> Client.perform_request()
  end
end
