defmodule PubNux.Subscription do
  alias __MODULE__

  @moduledoc """
    Suscribes messages to the provided channel

    ## Examples

    iex>  %Subscription{}
    ...>  |> Subscription.set_channel("channel_name")
    ...>  |> Subscription.set_time_token("time_token")
    ...>  |> Subscription.set_callback("callback")
    %PubNux.Subscription{
      callback: "callback",
      channel: "channel_name",
      path: nil,
      sub_key: nil,
      time_token: "time_token"
    }
  """

  defstruct path: nil,
            sub_key: nil,
            channel: nil,
            time_token: "0",
            callback: "defaultCallback"

  @typedoc """
  Represents Subscription struct with the PubNub API client
  """
  @type t :: %Subscription{path: String.t,
                          sub_key: String.t,
                          channel: String.t,
                          time_token: String.t,
                          callback: String.t}

  @spec build(Config.t) :: Subscription.t
  def build(config) do
    %Subscription{path: config.base_url <> "subscribe", sub_key: config.subscription_key}
  end

  @spec set_channel(Subscription.t, String.t) :: Subscription.t
  def set_channel(%Subscription{} = subscription, channel_name) do
    put_in(subscription.channel, channel_name)
  end

  @spec set_time_token(Subscription.t, String.t) :: Subscription.t
  def set_time_token(%Subscription{} = subscription, time_token) do
    put_in(subscription.time_token, time_token)
  end

  @spec set_callback(Subscription.t, String.t) :: Subscription.t
  def set_callback(%Subscription{} = subscription, callback) do
    put_in(subscription.callback, callback)
  end
end
