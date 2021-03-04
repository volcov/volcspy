defmodule Volcspy.Scraper do
  @site "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/"

  def get_reviews do
    get_reviews_per_page(@site, 2)
  end

  defp get_reviews_per_page(base_url, page) do
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
end
