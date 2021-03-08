defmodule Volcspy.ReviewFilter do
  def filter(review_list) do
    review_list
    |> Enum.map(fn review -> review.employees end)
    |> Enum.flat_map(fn employees -> Enum.map(employees, fn employee -> employee.name end) end)
    |> Enum.frequencies()
  end
end
