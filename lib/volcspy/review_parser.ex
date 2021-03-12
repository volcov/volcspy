defmodule Volcspy.ReviewParser do
  @type html_node :: {String.t(), list(), list(html_node())}

  @spec get_date(html_node()) :: String.t()
  def get_date(review) do
    [{_tag_name, _attributes, [date, _type]}] = Floki.find(review, ".review-date")
    Floki.text(date)
  end

  @spec get_title(html_node()) :: String.t()
  def get_title(review) do
    review
    |> Floki.find("h3")
    |> Floki.text()
    |> String.replace("\"", "")
  end

  @spec get_deal_rating(html_node()) :: String.t()
  def get_deal_rating(review) do
    review
    |> Floki.find(".rating-static:first-child")
    |> extract_rating_number()
  end

  @spec get_user(html_node()) :: String.t()
  def get_user(review) do
    review
    |> Floki.find("span")
    |> List.first()
    |> Floki.text()
  end

  @spec get_body(html_node()) :: String.t()
  def get_body(review) do
    review
    |> Floki.find(".review-content")
    |> Floki.text()
  end

  @spec get_review_ratings(html_node()) :: map()
  def get_review_ratings(review) do
    review
    |> Floki.find(".review-ratings-all")
    |> Floki.find(".td")
    |> Enum.chunk_every(2)
    |> Enum.reduce(%{}, fn [category, rating], acc ->
      Map.merge(acc, format_review_rating(category, rating))
    end)
  end

  @spec get_employees(html_node()) :: list()
  def get_employees(review) do
    review
    |> Floki.find(".review-employee")
    |> Enum.map(fn employee_node -> extract_employee_rating(employee_node) end)
  end

  defp format_review_rating(category_node, rating_node) do
    category =
      category_node
      |> Floki.text()
      |> String.replace(" ", "_")
      |> String.downcase()

    rating =
      if category == "recommend_dealer" do
        rating_node
        |> Floki.text()
        |> String.trim()
      else
        extract_rating_number(rating_node)
      end

    Map.put(%{}, category, rating)
  end

  defp extract_rating_number(rating_node) do
    rating_node
    |> Floki.attribute("class")
    |> List.first()
    |> String.split()
    |> Enum.filter(fn attribute -> String.match?(attribute, ~r/rating-\d/) end)
    |> List.first()
  end

  defp extract_employee_rating(employee_node) do
    name =
      employee_node
      |> Floki.find("a")
      |> Floki.text()
      |> String.trim()

    rating =
      employee_node
      |> Floki.find("span")
      |> Floki.text()
      |> String.trim()

    %{name: name, rating: rating}
  end
end
