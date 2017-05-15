defmodule PubNux.Client.HelpersTest do
  alias PubNux.Client
  alias PubNux.Client.Helpers
  use ExUnit.Case

  describe "gen_path/4" do
    test "builds a valid url with HTTP protocol" do
      url =
        Client.build()
        |> Helpers.gen_path("publish", "testing")

      assert url =~ "http://pubsub.pubnub.com/publish/"
    end

    test "builds a valid url with HTTPS protocol" do
      url = Helpers.gen_path(%Client{is_ssl: true}, "publish", "testing")
      assert url =~ "https://pubsub.pubnub.com/publish/"
    end
  end

  describe "perform_request/2" do
    test "call provided PubNuB service" do
      response =
        Client.build()
        |> Helpers.gen_path("publish", "testing")
        |> Helpers.perform_request(Poison.encode!(%{message: "Hola que hace"}))

      {:ok, body} = response
      assert body.status_code == 200
    end
  end
end
