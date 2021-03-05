defmodule Volcspy do
  alias Volcspy.ReviewParser
  alias Volcspy.Scraper

  def scan() do
    reviews = Scraper.get_reviews_html()
    ReviewParser.get_date(List.first(reviews))
  end
end
