defmodule PubNux.ClientTest do
  alias PubNux.Client
  alias PubNux.Config
  use ExUnit.Case
  use PubNux.VcrCase

  describe "gen_path/4" do
    test "builds a valid url with HTTP protocol" do
      url =
        Config.build()
        |> Client.gen_path("publish", "testing")

      assert url =~ "http://pubsub.pubnub.com/publish/"
    end
  end

  describe "perform_request/2" do
    test "call provided PubNuB service" do
      use_cassette "publish_pubnub_message" do
        response =
          Config.build()
          |> Client.gen_path("publish", "testing")
          |> Client.perform_request(Poison.encode!(%{message: "Hola que hace"}))

        {:ok, body} = response
        assert body.status_code == 200
      end
    end
  end
end
