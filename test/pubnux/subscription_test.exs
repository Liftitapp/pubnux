defmodule PubNux.SubscriptionTest do
  alias PubNux.{Subscription, Config}
  use ExUnit.Case

  describe "build/2" do
    setup do
      params = [{:callback, "callback"}, {:channel, "channel"}, {:time_token, "0"}]

      {:ok, params: params}
    end

    test "returns a valid Subscription structure", %{params: params} do
      subscription =
        Subscription.build(Config.build(), params)

      assert subscription.channel == params[:channel]
      assert subscription.callback == params[:callback]
      assert subscription.time_token == params[:time_token]
      assert subscription.path == "http://ps.pndsn.com/subscribe"
    end
  end
end
