defmodule Volcspy.Review do
  alias Volcspy.ReviewParser

  defstruct ~w[reference date deal_rating title user body review_ratings employees]a

  def new(review_html) do
    [review_map, review_ratings, employees] = build_review(review_html)

    %__MODULE__{
      reference: make_ref(),
      date: review_map.date,
      deal_rating: review_map.deal_rating,
      title: review_map.title,
      user: review_map.user,
      body: review_map.body,
      review_ratings: review_ratings,
      employees: employees
    }
  end

  defp build_review(review_html) do
    [
      build_review_map(review_html),
      ReviewParser.get_review_ratings(review_html),
      ReviewParser.get_employees(review_html)
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
