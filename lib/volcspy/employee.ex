defmodule Volcspy.Employee do
  @moduledoc """
  Employee is the structure that stores employee attributes
  """
  defstruct ~w[name employee_rating]a

  @doc """
  Returns a structure with Employee attributes

  ## Example

  iex> Employee.new(%{name: "Miss Peach", rating: "5.0"})
  %Volcspy.Employee{employee_rating: "5.0", name: "Miss Peach"}

  """

  @spec new(map()) :: struct()
  def new(employee) when is_map(employee) do
    %__MODULE__{
      name: employee.name,
      employee_rating: employee.rating
    }
  end
end
