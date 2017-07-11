defmodule PubNuxTest do
  use ExUnit.Case
  use PubNux.VcrCase

  describe "publish/4" do
    setup do
      message = %{
        "geo" => %{
            "geometry" => %{
              "coordinates" => [
                [[-74.06725643633541, 4.8293179395713]]]
            },
           "id" => 85670165,
           "properties" => %{},
           "type" => "Feature"
        }
      }

      {:ok, message: message}
    end

    test "Publish a new message", %{message: message} do
      use_cassette "subscription" do
        {:ok, callback} = PubNux.publish("testChannel", message, "testCallback", 0)
        assert callback == "testCallback([1,\"Sent\",\"14961805385605906\"])"
      end
    end

    test "creates a new request using a custom base url", %{message: message} do
      use_cassette "weird subscription" do
        {:error, _, _} = PubNux.publish("testChannel", message, "testCallback", 0, "wepa.com/")
      end
    end
  end
end
