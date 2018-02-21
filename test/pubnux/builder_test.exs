defmodule PubNux.BuilderTest do
  alias PubNux.{Config, Subscription, Publication}
  use ExUnit.Case

  describe "build_url/1" do
    test "builds a request Keyword receiving a Subscription structure" do
      params = [{:callback, "callback"}, {:channel, "channel"}, {:time_token, "0"}]

      request_params =
        Config.build()
        |> Subscription.build(params)
        |> PubNux.Builder.build_request_params()

      assert request_params[:method] == :get
      assert request_params[:url] =~ "http://ps.pndsn.com/subscribe/"
      assert request_params[:body] == []
      assert request_params[:headers] == []
    end

    test "builds a request Keyword receiving a Publication structure" do
      params = [
        {:channel, "channel"},
        {:callback, "callback"},
        {:message, %{message: "hey"}},
        {:store, 0}
      ]

      request_params =
        Config.build()
        |> Publication.build(params)
        |> PubNux.Builder.build_request_params()

      assert request_params[:method] == :post
      assert request_params[:url] =~ "http://ps.pndsn.com/publish/"
      assert request_params[:body] == ~s({"message":"hey"})
      assert request_params[:headers] == [{"Content-Type", "application/json"}]
    end
  end
end
