defmodule PubNuxTest do
  use ExUnit.Case
  use PubNux.VcrCase

  describe "publish/4" do
    test "Publish a new message" do
      use_cassette "subscription" do
        message =
          %{
            "geo" => %{
              "geometry" => %{
                "coordinates" => [
                  [[-74.06725643633541, 4.8293179395713]]]
              },
            "id" => 85670165,
            "properties" => %{},
            "type" => "Feature"}
          }

        {:ok, callback} = PubNux.publish("testChannel", message, "testCallback", 0)
        assert callback = "testCallback([1,\"Sent\",\"14961805385605906\"])"
      end
    end
  end
end
