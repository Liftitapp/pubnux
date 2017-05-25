defmodule PubNux.Publication do
  alias __MODULE__
  alias PubNux.Config

  @moduledoc """
    Publish messages to the provided channel

    ## Examples

    iex>  Config.build()
    ...>  |> Publication.build()
    ...>  |> Publication.set_channel("channel_name")
    ...>  |> Publication.set_callback("callback")
    ...>  |> Publication.set_message("hello world")
    %PubNux.Publication{
      path: "http://pubsub.pubnub.com/publish",
      callback: "callback",
      channel: "channel_name",
      message: "hello world",
      store: 0
    }

    ## You can also send a map as message
    iex>  Config.build()
    ...>  |> Publication.build()
    ...>  |> Publication.set_channel("channel_name")
    ...>  |> Publication.set_callback("callback")
    ...>  |> Publication.set_message(%{hola: "mundo"})
    ...>  |> Publication.set_store()
    %PubNux.Publication{
      path: "http://pubsub.pubnub.com/publish",
      callback: "callback",
      channel: "channel_name",
      message: ~s({"hola":"mundo"}
      store: 1),
    }
  """

  defstruct path: nil,
            sub_key: nil,
            pub_key: nil,
            channel: nil,
            callback: nil,
            message: nil,
            store: 0

  @typedoc """
  Represents Publication struct with the PubNub API client
  """
  @type t :: %Publication{path: String.t,
                          sub_key: String.t,
                          pub_key: String.t,
                          channel: String.t,
                          callback: String.t,
                          message: String.t,
                          store: boolean()}

  @spec build(Config.t) :: Publication.t
  def build(config) do
    %Publication{path: config.base_url <> "publish", sub_key: config.subscription_key, pub_key: config.publish_key}
  end

  @spec set_channel(Publication.t, String.t) :: Publication.t
  def set_channel(%Publication{} = publication, channel) do
    put_in(publication.channel, channel)
  end

  @spec set_callback(Publication.t, String.t) :: Publication.t
  def set_callback(%Publication{} = publication, callback) do
    put_in(publication.callback, callback)
  end

  @spec set_message(Publication.t, map()) :: Publication.t
  def set_message(%Publication{} = publication, message) when is_map(message) do
    payload = Poison.encode!(message)

    put_in(publication.message, payload)
  end


  @spec set_message(Publication.t, String.t) :: Publication.t
  def set_message(%Publication{} = publication, message) when is_binary(message) do
    put_in(publication.message, message)
  end

  def set_store(%Publication{} = publication) do
    put_in(publication.store, 1)
  end
end
