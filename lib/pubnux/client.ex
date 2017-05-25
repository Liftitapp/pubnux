defmodule PubNux.Client do
  @moduledoc """
  Wrap http client
  """
  alias PubNux.Builder

  @type http_response :: HTTPoison.Response.t
  @type http_error_response :: HTTPPoison.Error.t
  @type async_http_response :: HTTPoison.AsyncResponse.t

  @spec perform_request(any()) ::
  {:ok, http_response() | async_http_response()} | {:error, http_error_response()}
  def perform_request(resource) do
    resource
    |> Builder.build_url()
    |> send_request()
  end

  defp send_request(request_params) do
    HTTPoison.request(
      request_params[:method],
      request_params[:url],
      request_params[:body],
      request_params[:headers]
    )
  end
end
