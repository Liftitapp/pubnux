defmodule PubNux.Suscription do
  @moduledoc """
  Suscribes messages to the provided channel

  It must receieve a Config structure in the following way

  payload =
    Config.build()
    |> Suscription.set_channel("channel_name")
    |> Suscription.set_time_token("time_token")
    |> Suscription.set_callback("callback")

  Client.perform_request(payload)
  """
  alias PubNux.Config
  alias __MODULE__

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


end
