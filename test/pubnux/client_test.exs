defmodule PubNux.ClientTest do
  alias PubNux.{Client, Config, Subscription, Publication}
  use ExUnit.Case
  use PubNux.VcrCase

  describe "perform_request/2" do
    test "suscribes to specified PubNuB channel" do
      use_cassette "suscribe_to_pubnub_channel" do

        sub_args = [{:channel, "channel"}, {:callback, "callback"}, {:time_token, "0"}]

        {:ok, data} =
          Config.build()
          |> Subscription.build(sub_args)
          |> Client.perform_request()

        assert data != nil
      end
    end

    test "Publish a message to specified PubNux channel" do
      use_cassette "Publish_pubnub_message" do
        pub_params = [
          {:channel, "channel"},
          {:callback, "callback"},
          {:message, ~s({"Hola":"mundo"})},
          {:store, 0}
        ]

        {:ok, data} =
          Config.build()
          |> Publication.build(pub_params)
          |> Client.perform_request()

        assert data != nil
      end
    end
  end
end
