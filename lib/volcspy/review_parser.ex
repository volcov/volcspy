defmodule Volcspy.ReviewParser do
  def get_date(review) do
    [{_tag_name, _attributes, [date, _type]}] = Floki.find(review, ".review-date")
    Floki.text(date)
  end

  def get_title(review) do
    review
    |> Floki.find("h3")
    |> Floki.text()
    |> String.replace("\"", "")
  end

  def get_deal_rating(review) do
    review
    |> Floki.find(".rating-static:first-child")
    |> extract_rating()
  end

  def get_user(review) do
    review
    |> Floki.find("span")
    |> List.first()
    |> Floki.text()
  end

  def get_body(review) do
    review
    |> Floki.find(".review-content")
    |> Floki.text()
  end

  def get_review_ratings(review) do
    review
    |> Floki.find(".review-ratings-all")
    |> Floki.find(".td")
    |> Enum.chunk_every(2)
    |> Enum.map(fn [category, rating] -> format_review_rating(category, rating) end)
  end

  defp format_review_rating(category_node, rating_node) do
    category = Floki.text(category_node)
    rating = extract_rating(rating_node)

    {category, rating}
  end

  defp extract_rating(rating_node) do
    rating_node
    |> Floki.attribute("class")
    |> List.first()
    |> String.split()
    |> Enum.filter(fn attribute -> String.match?(attribute, ~r/rating-\d/) end)
    |> List.first()
  end
end
