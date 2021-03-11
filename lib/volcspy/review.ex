defmodule Volcspy.Review do
  alias Volcspy.Employee
  alias Volcspy.ReviewParser
  alias Volcspy.ReviewRating

  @moduledoc """
  Review is the structure that stores review attributes
  """

  defstruct ~w[reference date deal_rating title user body review_ratings employees]a

  @doc """
  Returns a structure with Review attributes

  ## Example

  Assuming that you have the following html_node()

  node = {"div",
  [
   {"class",
    "review-entry col-xs-12"}
  ],
  [
   {"a", [{"attr", "xxxxxxxx"}], []},
   {"div",
    [
      {"class",
       "review-date margin-bottom-md"}
    ],
    ...
    }
  }

  iex> Review.new(node)
  %Volcspy.Review{
    body: "bla bla bla bla bla bla",
    date: "January 30, 2021",
    deal_rating: "rating-50",
    employees: [
      %Volcspy.Employee{name: "Cel Mustard", rating: "4.0"},
      %Volcspy.Employee{name: "Miss Peach", rating: "5.0"}
    ],
    reference: #Reference<0.3446731673.2292187137.152936>,
    review_ratings: %Volcspy.ReviewRating{
      "customer_service" => "rating-50",
      "friendliness" => "rating-40",
      "overall_experience" => "rating-50",
      "pricing" => "rating-50",
      "quality_of_work" => "rating-50",
      "recommend_dealer" => "Yes"
    },
    title: "A Original Title",
    user: "- Foo Bar"
  }
  """

  @type html_node :: {String.t(), list(), list(html_node())}

  @spec new(html_node()) :: struct()
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
    review_map = build_review_map(review_html)

    review_ratings =
      review_html
      |> ReviewParser.get_review_ratings()
      |> ReviewRating.new()

    employees =
      review_html
      |> ReviewParser.get_employees()
      |> Enum.map(&Employee.new/1)

    [
      review_map,
      review_ratings,
      employees
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
