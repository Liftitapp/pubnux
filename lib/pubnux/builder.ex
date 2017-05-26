defprotocol PubNux.Builder do
  @moduledoc """
  The `PubNux.Builder` protocol should be implemented for any type that requires build
  a request params that eventually will feed a http call.
  """

  @spec build_request_params(any()) :: Keyword.t
  def build_request_params(resource)
end
