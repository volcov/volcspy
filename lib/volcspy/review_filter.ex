defmodule Volcspy.ReviewFilter do
  def filter(review_list) do
    review_list
    |> count_employees_reviews()
    |> three_most_appear()
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
end
