# ExMixpanel

**Elixir Client for Data Mixpanel API 2.0**

## Installation

The package can be installed by adding `ex_mixpanel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mixpanel, "~> 0.1.0"}
  ]
end
```

## API Key

Register for a user name and secret key and add it to the environment variable
```
export MIXPANEL_EXPORT_USERNAME="your username"
export MIXPANEL_EXPORT_SECRET="your secret"
export MIXPANEL_EXPORT_PROJECT_ID="your project id"
```

## Usage

Raw event export: https://developer.mixpanel.com/reference/raw-event-export



### Export data from mixpanel:

```elixir
ExMixpanel.export_events()
```

For more information, please check [the API](https://github.com/ngnclht1102/ex_mixpanel/blob/master/lib/ex_mixpanel/api.ex)

