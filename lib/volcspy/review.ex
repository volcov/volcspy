defmodule Volcspy.Review do
  alias Volcspy.Employee
  alias Volcspy.ReviewRating

  @moduledoc """
  Review is the structure that stores review attributes
  """

  defstruct ~w[reference date deal_rating title user body review_ratings employees]a

  @doc """
  Returns a structure with Review attributes

  ## Example

  iex> Review.new(review_map, review_ratings, employees)
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
  @type default :: any()

  @spec new(map(), map(), list(), default()) :: struct()
  def new(review_map, review_ratings, employees, ref \\ make_ref()) do
    %__MODULE__{
      reference: ref,
      date: review_map.date,
      deal_rating: review_map.deal_rating,
      title: review_map.title,
      user: review_map.user,
      body: review_map.body,
      review_ratings: ReviewRating.new(review_ratings),
      employees: Enum.map(employees, &Employee.new/1)
    }
  end
end
