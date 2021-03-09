defmodule Volcspy.ReviewFilter do
  def filter_suspect(review_list, quantity) do
    review_list
    |> count_employees_reviews()
    |> three_most_appear()
    |> Stream.flat_map(fn {name, _count} -> find_suspect_reviews(name, review_list) end)
    |> reviews_with_suspects_union(quantity)
  end

  defp count_employees_reviews(review_list) do
    review_list
    |> Stream.flat_map(& &1.employees)
    |> Stream.map(& &1.name)
    |> Enum.frequencies()
  end

  defp three_most_appear(review_frequencies) do
    review_frequencies
    |> Enum.sort(fn {_name_one, value_one}, {_name_two, value_two} -> value_two <= value_one end)
    |> Enum.slice(0..2)
  end

  defp find_suspect_reviews(suspect, review_list) do
    review_list
    |> Stream.filter(fn review -> worked_with?(suspect, review) end)
    |> Enum.to_list()
  end

  defp worked_with?(employee_name, review) do
    review.employees
    |> Stream.map(& &1.name)
    |> Enum.member?(employee_name)
  end

  defp reviews_with_suspects_union(reviews_list, quantity) do
    reviews_list
    |> Enum.frequencies_by(& &1.reference)
    |> Enum.sort(fn {_reference_one, value_one}, {_reference_two, value_two} ->
      value_two <= value_one
    end)
    |> Enum.slice(Range.new(0, quantity - 1))
  end
end
