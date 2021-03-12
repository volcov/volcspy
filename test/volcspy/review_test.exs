defmodule Volcspy.ReviewTest do
  use ExUnit.Case

  alias Volcspy.Review

  describe "new/3" do
    test "returns a review" do
      review_rating_map = %{
        "customer_service" => "rating-50",
        "friendliness" => "rating-40",
        "overall_experience" => "rating-30",
        "pricing" => "rating-50",
        "quality_of_work" => "rating-50",
        "recommend_dealer" => "Yes"
      }

      employees = [%{name: "Foo Bar", rating: "4.0"}, %{name: "Ted Bear", rating: "5.0"}]

      review_map = %{
        date: "January 23, 2021",
        title: "A Original Title",
        deal_rating: "rating-50",
        user: "- Foo Bar",
        body: "bla bla bla bla bla bla"
      }

      ref = make_ref()

      assert %Volcspy.Review{
               body: "bla bla bla bla bla bla",
               date: "January 23, 2021",
               deal_rating: "rating-50",
               employees: [
                 %Volcspy.Employee{employee_rating: "4.0", name: "Foo Bar"},
                 %Volcspy.Employee{employee_rating: "5.0", name: "Ted Bear"}
               ],
               reference: ref,
               review_ratings: %Volcspy.ReviewRating{
                 customer_service: "rating-50",
                 friendliness: "rating-40",
                 overall_experience: "rating-30",
                 pricing: "rating-50",
                 quality_of_work: "rating-50",
                 recommend_dealer: "Yes"
               },
               title: "A Original Title",
               user: "- Foo Bar"
             } ==
               Review.new(
                 review_map,
                 review_rating_map,
                 employees,
                 ref
               )
    end
  end
end
