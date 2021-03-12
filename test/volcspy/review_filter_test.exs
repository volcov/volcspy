defmodule Volcspy.ReviewFilterTest do
  use ExUnit.Case

  alias Volcspy.ReviewFilter

  describe "filter_suspect/2" do
    test "returns a list of suspects" do
      review_one = %Volcspy.Review{
        body: "bla bla bla bla bla bla",
        date: "January 23, 2021",
        deal_rating: "rating-50",
        employees: [
          %Volcspy.Employee{employee_rating: "4.0", name: "Foo Bar"}
        ],
        reference: make_ref(),
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
      }

      review_two = %Volcspy.Review{
        body: "bla bla bla bla bla bla",
        date: "January 23, 2021",
        deal_rating: "rating-50",
        employees: [
          %Volcspy.Employee{employee_rating: "5.0", name: "Ted Bear"}
        ],
        reference: make_ref(),
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
      }

      review_three = %Volcspy.Review{
        body: "bla bla bla bla bla bla",
        date: "January 23, 2021",
        deal_rating: "rating-50",
        employees: [
          %Volcspy.Employee{employee_rating: "4.0", name: "Foo Bar"},
          %Volcspy.Employee{employee_rating: "5.0", name: "Miss Peach"}
        ],
        reference: make_ref(),
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
      }

      review_four = %Volcspy.Review{
        body: "bla bla bla bla bla bla",
        date: "January 23, 2021",
        deal_rating: "rating-50",
        employees: [
          %Volcspy.Employee{employee_rating: "4.0", name: "Foo Bar"},
          %Volcspy.Employee{employee_rating: "5.0", name: "Miss Peach"}
        ],
        reference: make_ref(),
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
      }

      review_five = %Volcspy.Review{
        body: "bla bla bla bla bla bla",
        date: "January 23, 2021",
        deal_rating: "rating-50",
        employees: [
          %Volcspy.Employee{employee_rating: "5.0", name: "Miss Peach"}
        ],
        reference: make_ref(),
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
      }

      assert [review_three, review_four] ==
               ReviewFilter.filter_suspect(
                 [
                   review_one,
                   review_two,
                   review_three,
                   review_four,
                   review_five
                 ],
                 2
               )
    end
  end
end
