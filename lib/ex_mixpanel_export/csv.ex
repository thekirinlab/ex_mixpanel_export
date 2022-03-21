defmodule ExMixpanelExport.Csv do
  @moduledoc """
  CSV export services
  """

  @bom :unicode.encoding_to_bom(:utf8)
  alias ExMixpanelExport.CSVParser
  require Logger

  def to_csv(events) do
    utf8_csv =
      [csv_header() | csv_data(events)]
      |> CSVParser.dump_to_iodata()

    [@bom, utf8_csv]
  end

  defp csv_header do
    [
      "event",
      "distinct_id",
      "wifi",
      "mp_lib",
      "model",
      "app_build_number",
      "app_version_string",
      "had_persisted_distinct_id",
      "app_release",
      "region",
      "index",
      "os",
      "manufacturer",
      "insert_id",
      "referrer",
      "mp_api_endpoint",
      "mp_country_code",
      "mp_api_timestamp_ms",
      "google_play_services",
      "has_telephone",
      "mp_processing_time_ms",
      "app_version",
      "time",
      "device_id",
      "screen_height",
      "lib_version",
      "screen_width",
      "brand",
      "bluetooth_version",
      "carrier",
      "city",
      "has_nfc",
      "screen_dpi",
      "os_version"
    ]
  end

  defp csv_data(events) do
    events
      |> Enum.map(&data_row/1)
  end

  defp data_row(event) do
    [
      event["event"],
      event["properties"]["distinct_id"],
      event["properties"]["$wifi"],
      event["properties"]["mp_lib"],
      event["properties"]["$model"],
      event["properties"]["$app_build_number"],
      event["properties"]["$app_version_string"],
      event["properties"]["$had_persisted_distinct_id"],
      event["properties"]["$app_release"],
      event["properties"]["$region"],
      event["properties"]["index"],
      event["properties"]["$os"],
      event["properties"]["$manufacturer"],
      event["properties"]["$insert_id"],
      event["properties"]["referrer"],
      event["properties"]["$mp_api_endpoint"],
      event["properties"]["mp_country_code"],
      event["properties"]["$mp_api_timestamp_ms"],
      event["properties"]["$google_play_services"],
      event["properties"]["$has_telephone"],
      event["properties"]["mp_processing_time_ms"],
      event["properties"]["$app_version"],
      event["properties"]["time"],
      event["properties"]["$device_id"],
      event["properties"]["$screen_height"],
      event["properties"]["$lib_version"],
      event["properties"]["$screen_width"],
      event["properties"]["$brand"],
      event["properties"]["$bluetooth_version"],
      event["properties"]["$carrier"],
      event["properties"]["$city"],
      event["properties"]["$has_nfc"],
      event["properties"]["$screen_dpi"],
      event["properties"]["$os_version"]
    ]
  end
end
