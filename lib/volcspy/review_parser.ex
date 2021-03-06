defmodule Volcspy.ReviewParser do
  def get_date(review) do
    [{_tag_name, _attributes, [date, _type]}] = Floki.find(review, ".review-date")
    Floki.text(date)
  end

  def get_title(review) do
    review
    |> Floki.find("h3")
    |> String.replace("\"", "")
  end

  def get_deal_rating(review) do
    review
    |> Floki.find(".rating-static:first-child")
    |> Floki.attribute("class")
    |> List.first()
    |> String.split()
    |> Enum.filter(fn attribute -> String.match?(attribute, ~r/rating-\d/) end)
    |> List.first()
  end
end
