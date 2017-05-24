defmodule PubNux.Suscription do
  alias __MODULE__

  @moduledoc """
    Suscribes messages to the provided channel

    ## Examples

    iex>  Suscription.build()
    ...>  |> Suscription.set_channel("channel_name")
    ...>  |> Suscription.set_time_token("time_token")
    ...>  |> Suscription.set_callback("callback")
    %PubNux.Suscription{callback: "callback", time_token: "time_token", channel: "channel_name"}
  """

  defstruct uri: "/suscribe",
            channel: nil,
            time_token: nil,
            callback: nil

  @typedoc """
  Represents suscription struct with the PubNub API client
  """
  @type t :: %Suscription{uri: String.t,
                          channel: String.t,
                          time_token: String.t,
                          callback: String.t}

  @spec build() :: Suscription.t
  def build do
    %Suscription{}
  end

  @spec set_channel(Suscription.t, String.t) :: Suscription.t
  def set_channel(%Suscription{} = suscription, channel_name) do
    put_in(suscription.channel, channel_name)
  end

  @spec set_time_token(Suscription.t, String.t) :: Suscription.t
  def set_time_token(%Suscription{} = suscription, time_token) do
    put_in(suscription.time_token, time_token)
  end

  @spec set_callback(Suscription.t, String.t) :: Suscription.t
  def set_callback(%Suscription{} = suscription, callback) do
    put_in(suscription.callback, callback)
  end
end
