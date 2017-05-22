defmodule PubNux.Client.Helpers do
  @moduledoc """
  Wrap client helpers
  """
  alias PubNux.Client

  @spec call_service(Client.t, String.t, String.t) ::
  {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def call_service(client, channel, message) do
    gen_path(client, "publish", channel)
    |> perform_request(message)
  end

  @spec gen_path(Client.t, String.t, String.t, String.t) :: String.t
  def gen_path(client, service, channel, callback \\ "defaultCallback") do
    [
     client.base_url,
     service,
     client.publish_key,
     client.subscription_key,
     "0",
     channel,
     callback
    ]
    |> Enum.join("/")
    |> URI.encode()
  end

  @spec perform_request(String.t, String.t) ::
  {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def perform_request(url, body) do
    HTTPoison.post(url ,body, %{"Content-Type" => "application/json"})
  end
end
