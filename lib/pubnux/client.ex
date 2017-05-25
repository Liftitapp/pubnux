defmodule PubNux.Client do
  @moduledoc """
  Wrap client Client
  """
  alias PubNux.{Subscription, Publication}

  @type http_response :: HTTPoison.Response.t
  @type http_error_response :: HTTPPoison.Error.t
  @type async_http_response :: HTTPoison.AsyncResponse.t

  @spec perform_request(any()) ::
  {:ok, http_response() | async_http_response()} | {:error, http_error_response()}
  def perform_request(%Subscription{} = subscription) do
    [subscription.path, subscription.sub_key, subscription.channel, subscription.callback, subscription.time_token]
    |> Enum.join("/")
    |> URI.encode()
    |> send_request()
  end
  def perform_request(%Publication{} = publication) do
    store =
      if publication.store, do: 1, else: 0

    [publication.path, publication.pub_key, publication.sub_key, store, publication.channel, publication.callback]
    |> Enum.join("/")
    |> URI.encode()
    |> send_request(publication.message)
  end

  defp send_request(url, body) do
    HTTPoison.post(url ,body, %{"Content-Type" => "application/json"})
  end

  defp send_request(url) do
    HTTPoison.get(url)
  end
end
