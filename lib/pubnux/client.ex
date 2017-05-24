defmodule PubNux.Client do
  @moduledoc """
  Wrap client Client
  """
  alias PubNux.Config
  alias PubNux.Suscription

  @type http_response :: HTTPoison.Response.t
  @type http_error_response :: HTTPPoison.Error.t
  @type async_http_response :: HTTPoison.AsyncResponse.t

  @doc """
  Perform the requested PubNub action calling the API
  """
  @spec call_service(Config.t, String.t, String.t, atom()) ::
  {:ok, http_response() | async_http_response()} | {:error, http_error_response()}
  def call_service(%Config{} = config, channel, message, :publish) do
    config
    |> gen_path("publish", channel)
    |> perform_request(message)
  end
  def call_service(%Config{} = config, %Suscription{} = suscription) do
    #gen_path(config, suscription)
    #|> perform_request(callback)
  end

  @spec gen_path(Config.t, String.t, String.t, String.t) :: String.t
  def gen_path(%Config{} = config, service, channel, callback \\ "defaultCallback") do
    [
     config.base_url,
     service,
     config.publish_key,
     config.subscription_key,
     "0",
     channel,
     callback
    ]
    |> Enum.join("/")
    |> URI.encode()
  end

  @spec perform_request(String.t, String.t) ::
  {:ok, http_response() | async_http_response()} | {:error, http_error_response()}
  def perform_request(url, body) do
    HTTPoison.post(url ,body, %{"Content-Type" => "application/json"})
  end
end
