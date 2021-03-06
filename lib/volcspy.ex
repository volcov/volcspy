defmodule Volcspy do
  alias Volcspy.ReviewParser
  alias Volcspy.Scraper

  def scan() do
    reviews = Scraper.get_reviews_html()
    # ReviewParser.get_date(List.first(reviews))
    # ReviewParser.get_title(List.first(reviews))
    # ReviewParser.get_deal_rating(List.first(reviews))
    ReviewParser.get_user(List.first(reviews))
  end
end
