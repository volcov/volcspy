defmodule Volcspy.ReviewRating do
  @moduledoc """
  ReviewRating is the structure that stores review ratings
  """
  defstruct ~w[customer_service quality_of_work friendliness pricing overall_experience recommend_dealer]a

  @doc """
  Returns a structure with review ratings

  ## Example

  map = %{
  "customer_service" => "rating-50",
  "friendliness" => "rating-40",
  "overall_experience" => "rating-30",
  "pricing" => "rating-50",
  "quality_of_work" => "rating-50",
  "recommend_dealer" => "Yes"
  }

  iex> ReviewRating.new(map)
  %Volcspy.ReviewRating{
      customer_service: "rating-50",
      friendliness: "rating-40",
      overall_experience: "rating-30",
      pricing: "rating-50",
      quality_of_work: "rating-50",
      recommend_dealer: "Yes"
    }

  """
  @spec new(map()) :: struct()
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
