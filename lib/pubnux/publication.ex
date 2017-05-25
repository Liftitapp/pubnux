defmodule PubNux.Publication do
  @moduledoc """
    Publish messages to the provided channel
  """
  alias __MODULE__

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

  @spec build(Config.t, Keyword.t) :: Publication.t
  def build(config, pub_params) do
    %Publication{
      channel: pub_params[:channel],
      callback: pub_params[:callback],
      message: pub_params[:message],
      store: pub_params[:store],
      path: config.base_url <> "publish",
      sub_key: config.subscription_key,
      pub_key: config.publish_key
    }
  end

  defimpl PubNux.Builder do
    def build_url(publication) do
      store =
        if publication.store, do: 1, else: 0

      url =
        [publication.path, publication.pub_key, publication.sub_key, store, publication.channel, publication.callback]
        |> Enum.join("/")
        |> URI.encode()

      [
        method: :post,
        url: url,
        body: publication.message,
        headers: [{"Content-Type", "application/json"}]
      ]
    end
  end

end
