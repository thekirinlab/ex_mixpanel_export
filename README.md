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
To get username, secret, and project id. Please go to https://developer.mixpanel.com/reference/service-accounts and follow the document there. 

Register for a username and secret key and add it to the environment variable
```
export MIXPANEL_EXPORT_USERNAME="your username"
export MIXPANEL_EXPORT_SECRET="your secret"
export MIXPANEL_EXPORT_PROJECT_ID="your project id"
```

in config.exs:

```
config :ex_mixpanel_export,
  username: {:system, "MIXPANEL_EXPORT_USERNAME"},
  secret: {:system, "MIXPANEL_EXPORT_SECRET"},
  project_id: {:system, "MIXPANEL_EXPORT_PROJECT_ID"}
```

## Usage

Raw event export: https://developer.mixpanel.com/reference/raw-event-export


### Export data from mixpanel and download as csv

```elixir

csv_content = ExMixpanelExport.export_events(~D[2022-03-17], ~D[2022-03-17])
conn
|> put_resp_content_type("text/csv")
|> put_resp_header(
     "content-disposition",
     "attachment; filename=\"mixpanel_events.csv\""
   )
|> send_resp(200, csv_content)
```

For more information, please check [the API](https://hexdocs.pm/ex_mixpanel_export/1.0.1/ExMixpanelExport.Config.html)
