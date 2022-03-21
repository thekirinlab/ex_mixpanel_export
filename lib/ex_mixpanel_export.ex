defmodule ExMixpanelExport do
  alias ExMixpanelExport.{Api, Csv}

  use Timex

  def export_events(%Date{} = from, %Date{} = to) do
    with {:ok, from_str} <- format_date(from),
         {:ok, to_str} <- format_date(to)
    do
      events = Api.get(
        "/export",
        %{
          from_date: from_str,
          to_date: to_str
        }
      )
      events |> Csv.to_csv()
    end
  end

  defp format_date(%Date{} = date) do
    Timex.format(date, "%Y-%m-%d", :strftime)
  end
end
