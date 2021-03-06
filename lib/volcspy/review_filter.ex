defmodule Volcspy.ReviewFilter do
  @moduledoc """
  ReviewFilter is responsible for filtering the X most suspicious reviews,
  where X is a parameter of filter_suspect/2

  the choice is made through the following steps:
  1. sum of the number of times each employee appears in the list
  2. selects the first three
  3. look for the reviews that contain the set of those selected in step 2
  """

  @doc """
  Returns a list of suspected reviews
  """
  @spec filter_suspect(list(), integer()) :: list()
  def filter_suspect(review_list, quantity) do
    review_list
    |> count_employees_reviews()
    |> three_most_appear()
    |> Enum.flat_map(fn {name, _count} -> find_suspect_reviews(name, review_list) end)
    |> reviews_with_suspects_union(quantity)
    |> show_suspected_reviews(review_list)
  end

  defp count_employees_reviews(review_list) do
    review_list
    |> Enum.flat_map(& &1.employees)
    |> Enum.map(& &1.name)
    |> Enum.frequencies()
  end

  defp three_most_appear(review_frequencies) do
    review_frequencies
    |> Enum.sort(fn {_name_one, value_one}, {_name_two, value_two} -> value_two <= value_one end)
    |> Enum.take(3)
  end

  defp find_suspect_reviews(suspect, review_list) do
    Enum.filter(review_list, fn review -> worked_with?(suspect, review) end)
  end

  defp worked_with?(employee_name, review) do
    review.employees
    |> Enum.map(& &1.name)
    |> Enum.member?(employee_name)
  end

  defp reviews_with_suspects_union(reviews_list, quantity) do
    reviews_list
    |> Enum.frequencies_by(& &1.reference)
    |> Enum.sort(fn {_reference_one, value_one}, {_reference_two, value_two} ->
      value_two <= value_one
    end)
    |> Enum.take(quantity)
    |> Enum.map(fn {reference, _count} -> reference end)
  end

  defp show_suspected_reviews(reference_list, review_list) do
    for reference <- reference_list do
      Enum.find(review_list, fn review -> review.reference == reference end)
    end
  end
end
