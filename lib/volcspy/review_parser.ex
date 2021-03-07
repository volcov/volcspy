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
    |> extract_rating_number()
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
    |> Enum.reduce(%{}, fn [category, rating], acc ->
      Map.merge(acc, format_review_rating(category, rating))
    end)
  end

  defp format_review_rating(category_node, rating_node) do
    category =
      category_node
      |> Floki.text()
      |> String.replace(" ", "_")
      |> String.downcase()

    rating =
      if category == "recommend_dealer" do
        rating_node
        |> Floki.text()
        |> String.trim()
      else
        extract_rating_number(rating_node)
      end

    Map.put(%{}, category, rating)
  end

  defp extract_rating_number(rating_node) do
    rating_node
    |> Floki.attribute("class")
    |> List.first()
    |> String.split()
    |> Enum.filter(fn attribute -> String.match?(attribute, ~r/rating-\d/) end)
    |> List.first()
  end
end
