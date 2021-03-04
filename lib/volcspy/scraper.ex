defmodule Volcspy.Scraper do
  require Logger

  @page_range 1..5

  def get_reviews_html() do
    Stream.map(@page_range, fn page ->
      Task.async(fn -> get_and_filter_review_in_page(page) end)
    end)
    |> Stream.map(fn task -> Task.await(task, 10_000) end)
    |> Stream.concat()
    |> Enum.to_list()
  end

  defp get_and_filter_review_in_page(page) do
    site = Application.get_env(:volcspy, :base_url)

    with {:ok, html} <- get_reviews_html_per_page(site, page) do
      filter_review_entries(html)
    else
      {:error, :page_not_found} ->
        Logger.warn("Skipping results, because page not found")
        []

      _ ->
        Logger.warn("Skipping results, unknown error")
        []
    end
  end

  defp get_reviews_html_per_page(nil, _) do
    Logger.error("I don't have the url, please set in VOLCSPY_BASE_URL env")
  end

  defp get_reviews_html_per_page(base_url, page) do
    url = base_url <> "page#{page}"

    case http_client().get(url) do
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

  defp http_client() do
    Application.get_env(:volcspy, :http_client)
  end
end
