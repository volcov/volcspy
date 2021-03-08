defmodule Volcspy.Employee do
  defstruct ~w[name employee_rating]a

  def new(employee) do
    %__MODULE__{
      name: employee.name,
      employee_rating: employee.rating
    }
  end
end
