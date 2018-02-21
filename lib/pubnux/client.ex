defmodule PubNux.Client do
  @moduledoc """
  Wraps http client for the PubNub API
  """
  alias PubNux.Builder

  @type http_response :: {:ok, String.t}
  @type http_bad_request_response :: {:error, String.t, code: Integer.t}
  @type http_error_response :: {:error, String.t}

  @doc """
  Calls the provided service in the PubNub API. Here, `resource` represents a PubNub service,
  for instance the structure `%PubNux.Subscription{}` builds the request params requred for PubNub.

    ## Examples

      iex> Config.build()
      ...> |> Subscription.build(subs_keyword)
      ...> |> Client.perform_request()
      {:ok, "defaultCallback([[],\"14957412179337572\"])"}


      iex> Config.build()
      ...> |> Publication.build(subs_keyword)
      ...> |> Client.perform_request()
      {:ok, "defaultCallback([[],\"14957412179337572\"])"}
  """
  @spec perform_request(any()) ::
    {:ok, http_response()} | {:error, http_error_response() | http_bad_request_response()}
  def perform_request(resource) do
    resource
    |> Builder.build_request_params()
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
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status_code}} ->
        {:error, body, code: status_code}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Unable to comunicate with PubNux service. Reason: #{reason}"}
    end
  end
end
