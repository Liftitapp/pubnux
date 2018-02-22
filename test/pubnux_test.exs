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
        assert "testCallback([1,\"Sent\",\"15192447398578186\"])" = callback
      end
    end
  end
end
