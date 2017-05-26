defmodule PubNux.PublicationTest do
  alias PubNux.{Publication, Config}
  use ExUnit.Case

  describe "buid/2" do
    setup do
      params = [
        {:channel, "channel"},
        {:callback, "callback"},
        {:message, %{message: "hey"}},
        {:store, 0}
      ]

      {:ok, params: params}
    end

    test "returns a valid Publication structure", %{params: params} do
      publication =
        Publication.build(Config.build(), params)

      assert publication.channel == params[:channel]
      assert publication.callback == params[:callback]
      assert publication.message == ~s({"message":"hey"})
      assert publication.path == "http://ps.pndsn.com/publish"
    end
  end
end
