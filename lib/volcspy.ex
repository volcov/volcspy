defmodule Volcspy do
  alias Volcspy.Review
  alias Volcspy.ReviewFilter
  alias Volcspy.Scraper

  def scan() do
    Scraper.get_reviews_html()
    |> Enum.map(fn review_html -> Review.new(review_html) end)
    |> ReviewFilter.filter_suspect(3)
  end
end
