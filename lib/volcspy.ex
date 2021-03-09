defmodule Volcspy do
  alias Volcspy.Review
  alias Volcspy.ReviewFilter
  alias Volcspy.ReviewParser
  alias Volcspy.Scraper

  def scan() do
    Scraper.get_reviews_html()
    |> Enum.map(fn review_html -> build_review(review_html) end)
    |> Enum.map(fn [review_map, review_rating, employees] ->
      Review.new(review_map, review_rating, employees)
    end)
    |> ReviewFilter.filter_suspect()
  end

  defp build_review(review) do
    [
      build_review_map(review),
      ReviewParser.get_review_ratings(review),
      ReviewParser.get_employees(review)
    ]
  end

  defp build_review_map(review) do
    %{}
    |> Map.put(:date, ReviewParser.get_date(review))
    |> Map.put(:title, ReviewParser.get_title(review))
    |> Map.put(:deal_rating, ReviewParser.get_deal_rating(review))
    |> Map.put(:user, ReviewParser.get_user(review))
    |> Map.put(:body, ReviewParser.get_body(review))
  end
end
