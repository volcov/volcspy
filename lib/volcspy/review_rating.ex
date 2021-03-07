defmodule Volcspy.ReviewRating do
  defstruct ~w[customer_service quality_of_work friendliness pricing overall_experience recommend_dealer]a

  def new(review_rating) when is_map(review_rating) do
    %__MODULE__{
      customer_service: review_rating["customer_service"],
      quality_of_work: review_rating["quality_of_work"],
      friendliness: review_rating["friendliness"],
      pricing: review_rating["pricing"],
      overall_experience: review_rating["overall_experience"],
      recommend_dealer: review_rating["recommend_dealer"]
    }
  end
end
