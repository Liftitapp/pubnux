defmodule PubNux.Publication do
  alias __MODULE__

  @moduledoc """
    Publish messages to the provided channel

    ## Examples

    iex>  Publication.build()
    ...>  |> Publication.set_channel("channel_name")
    ...>  |> Publication.set_callback("callback")
    ...>  |> Publication.set_message("hello world")
    %PubNux.Publication{callback: "callback", channel: "channel_name", message: "hello world"}

    ## You can also send a map as message

    iex>  Publication.build()
    ...>  |> Publication.set_channel("channel_name")
    ...>  |> Publication.set_callback("callback")
    ...>  |> Publication.set_message(%{hola: "mundo"})
    %PubNux.Publication{callback: "callback", channel: "channel_name", message: ~s({"hola":"mundo"}), uri: "/publish"}
  """

  defstruct uri: "/publish",
            channel: nil,
            callback: nil,
            message: nil

  @typedoc """
  Represents Publication struct with the PubNub API client
  """
  @type t :: %Publication{uri: String.t,
                          channel: String.t,
                          callback: String.t,
                          message: String.t}

  @spec build() :: Publication.t
  def build do
    %Publication{}
  end

  @spec set_channel(Publication.t, String.t) :: Publication.t
  def set_channel(%Publication{} = publication, channel) do
    put_in(publication.channel, channel)
  end

  @spec set_channel(Publication.t, String.t) :: Publication.t
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
end
