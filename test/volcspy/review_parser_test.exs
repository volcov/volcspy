defmodule Volcspy.ReviewParserTest do
  use ExUnit.Case

  alias Volcspy.ReviewParser

  setup do
    review_html =
      "test/support/fake_reviews.html"
      |> File.read!()
      |> Floki.parse_document!()

    {:ok, %{review_html: review_html}}
  end

  describe "get_date/1" do
    test "returns a date", %{review_html: review_html} do
      assert "February 25, 2021" == ReviewParser.get_date(review_html)
    end
  end

  describe "get_title/1" do
    test "returns a title", %{review_html: review_html} do
      assert "Here will be a nice title" == ReviewParser.get_title(review_html)
    end
  end

  describe "get_deal_rating/1" do
    test "returns a deal rating", %{review_html: review_html} do
      assert "rating-50" == ReviewParser.get_deal_rating(review_html)
    end
  end

  describe "get_body/1" do
    test "returns a body", %{review_html: review_html} do
      assert "I want to read a body =)" == ReviewParser.get_body(review_html)
    end
  end

  describe "get_user/1" do
    test "returns a user", %{review_html: review_html} do
      assert "- Foo Bar" == ReviewParser.get_user(review_html)
    end
  end

  describe "get_review_ratings/1" do
    test "returns a review_ratings", %{review_html: review_html} do
      assert %{
               "customer_service" => "rating-50",
               "friendliness" => "rating-50",
               "overall_experience" => "rating-50",
               "pricing" => "rating-50",
               "quality_of_work" => "rating-50",
               "recommend_dealer" => "Yes"
             } == ReviewParser.get_review_ratings(review_html)
    end
  end

  describe "get_employees/1" do
    test "returns a list of employees", %{review_html: review_html} do
      assert [%{name: "Miss Peach", rating: "5.0"}] == ReviewParser.get_employees(review_html)
    end
  end
end
