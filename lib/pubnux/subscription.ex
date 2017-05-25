defmodule PubNux.Subscription do
  @moduledoc """
    Suscribes messages to the provided channel
  """
  alias __MODULE__

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

  @spec build(Config.t, Keyword.t) :: Subscription.t
  def build(config, subs_params) do
    %Subscription{
      path: config.base_url <> "subscribe",
      sub_key: config.subscription_key,
      channel: subs_params[:channel],
      time_token: subs_params[:time_token],
      callback: subs_params[:callback]
    }
  end

  defimpl PubNux.Builder do
    def build_url(subscription) do
      url =
        [subscription.path, subscription.sub_key, subscription.channel, subscription.callback, subscription.time_token]
        |> Stream.filter(fn(v) -> v != nil end)
        |> Enum.join("/")
        |> URI.encode()

      [method: "GET", url: url, body: [], headers: []]
    end
  end
end
