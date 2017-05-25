defmodule PubNux.ClientTest do
  alias PubNux.{Client, Config, Subscription, Publication}
  use ExUnit.Case
  use PubNux.VcrCase

  describe "perform_request/2" do
    test "suscribes to specified PubNuB channel" do
      use_cassette "suscribe_to_pubnub_channel" do
        data =
          Config.build()
          |> Subscription.build()
          |> Subscription.set_channel("channel_name")
          |> Client.perform_request()

        {:ok, response} = data
        assert response.status_code == 200
        assert response.body != nil
      end
    end

    test "Publish a message to specified PubNux channel" do
      use_cassette "Publish_pubnub_message" do
        data =
          Config.build()
          |> Publication.build()
          |> Publication.set_channel("channel_name")
          |> Publication.set_callback("callback")
          |> Publication.set_message(%{hola: "mundo"})
          |> Publication.set_store()
          |> Client.perform_request()

        {:ok, response} = data
        assert response.status_code == 200
        assert response.body != nil
      end
    end
  end
end
