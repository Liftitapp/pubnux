defmodule PubNux.Client do
  @moduledoc """
  Wrap http client
  """
  alias PubNux.Builder

  @type http_response :: {:ok, String.t}
  @type http_bad_request_response :: {:error, String.t, code: Integer.t}
  @type http_error_response :: {:error, String.t}

  @spec perform_request(any()) ::
  {:ok, http_response()} | {:error, http_error_response() | http_bad_request_response()}
  def perform_request(resource) do
    resource
    |> Builder.build_url()
    |> send_request()
  end

  defp send_request(request_params) do
    response =
      HTTPoison.request(
        request_params[:method],
        request_params[:url],
        request_params[:body],
        request_params[:headers]
      )

    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: 200}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status_code}} when status_code > 400 ->
        {:error, body, code: status_code}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Unable to comunicate with PubNux service. Reason: #{reason}"}
    end
  end
end
