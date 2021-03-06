defmodule Volcspy.Review do
  defstruct ~w[date deal_rating title user body review_raitings employees]a

  def new(review) do
    %__MODULE__{
      date: review.date,
      deal_rating: review.deal_rating,
      title: review.title,
      user: review.user,
      body: review.body
    }
  end
end
