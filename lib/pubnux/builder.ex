defprotocol PubNux.Builder do

  @spec build_url(any()) :: map()
  def build_url(resource)
end
