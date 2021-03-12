defmodule Volcspy.ReviewRatingTest do
  use ExUnit.Case

  alias Volcspy.ReviewRating

  describe "new/i" do
    test "returns a ReviewRating" do
      review_rating_map = %{
        "customer_service" => "rating-50",
        "friendliness" => "rating-40",
        "overall_experience" => "rating-30",
        "pricing" => "rating-50",
        "quality_of_work" => "rating-50",
        "recommend_dealer" => "Yes"
      }

      assert %ReviewRating{
               customer_service: "rating-50",
               friendliness: "rating-40",
               overall_experience: "rating-30",
               pricing: "rating-50",
               quality_of_work: "rating-50",
               recommend_dealer: "Yes"
             } == ReviewRating.new(review_rating_map)
    end
  end
end
