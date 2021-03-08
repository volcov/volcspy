defmodule Volcspy.ReviewFilter do
  def filter(review_list) do
    count_employees_reviews(review_list)
  end

  defp count_employees_reviews(review_list) do
    review_list
    |> Stream.flat_map(& &1.employees)
    |> Stream.map(& &1.name)
    |> Enum.frequencies()
  end
end
