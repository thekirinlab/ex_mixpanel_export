# ExMixpanelExport CSV

**Elixir Client for Data Mixpanel API 2.0**

## Installation

The package can be installed by adding `ex_mixpanel_export` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mixpanel_export, "~> 1.0.1"}
  ]
end
```

## API Key

Register for a username and secret key and add it to the environment variable
```
export MIXPANEL_EXPORT_USERNAME="your username"
export MIXPANEL_EXPORT_SECRET="your secret"
export MIXPANEL_EXPORT_PROJECT_ID="your project id"
```

## Usage

Raw event export: https://developer.mixpanel.com/reference/raw-event-export



### Export data from mixpanel and download as csv

```elixir

csv_content = ExMixpanel.export_events(~D[2022-03-17], ~D[2022-03-17])
conn
|> put_resp_content_type("text/csv")
|> put_resp_header(
     "content-disposition",
     "attachment; filename=\"mixpanel_events.csv\""
   )
|> send_resp(200, csv_content)
```

For more information, please check [the API](https://github.com/thekirinlab/ex_mixpanel_export/blob/master/lib/ex_mixpanel_export/api.ex)

