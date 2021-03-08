defmodule Volcspy.Review do
  defstruct ~w[date deal_rating title user body review_ratings employees]a

  def new(review, review_ratings, employees)
      when is_map(review) and is_map(review_ratings) and is_list(employees) do
    %__MODULE__{
      date: review.date,
      deal_rating: review.deal_rating,
      title: review.title,
      user: review.user,
      body: review.body,
      review_ratings: review_ratings,
      employees: employees
    }
  end
end
