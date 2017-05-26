# PubNux
[![Build Status](https://travis-ci.org/MrCoffey/pubnux.svg?branch=master)](https://travis-ci.org/MrCoffey/pubnux)

A wrapper for PubNub's API.

**NOTE**: This is a work in progress and so far only supports message publication. PR are always welcome

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pubnux` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:pubnux, "~> 0.1.0"}]
end
```

## Configuration

```elixir
config :pubnux,
  publish_key: "your_publication_key",
  subscription_key: "your_susbscription_key",
  is_ssl: false
```

## Usage

```elixir
alias PubNux

PubNux.subscribe("channel-name")
```

## Contributing

You can run the tests with the following command:

```elixir
mix test
```
