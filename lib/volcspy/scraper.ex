defmodule Volcspy.Scraper do
  require Logger

  @site "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/"
  @page_range [1, 2, 3, "error", 5]

  def get_reviews do
    Stream.map(@page_range, fn page -> Task.async(fn -> seek_and_filter(page) end) end)
    |> Stream.map(fn task -> Task.await(task, 14500) end)
    |> Stream.concat()
    |> Enum.to_list()
  end

  defp seek_and_filter(page) do
    with {:ok, html} <- get_reviews_html_per_page(@site, page) do
      filter_review_entries(html)
    else
      {:error, :page_not_found} ->
        Logger.warn("Skipping results, because page not found")
        []

      _ ->
        Logger.warn("Skipping results, unknow error")
        []
    end
  end

  defp get_reviews_html_per_page(base_url, page) do
    url = base_url <> "page#{page}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :page_not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp filter_review_entries(review_html_page) do
    {:ok, document} = Floki.parse_document(review_html_page)
    Floki.find(document, ".review-entry")
  end
end
