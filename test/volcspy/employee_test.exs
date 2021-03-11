defmodule Volcspy.EmployeeTest do
  use ExUnit.Case

  alias Volcspy.Employee

  describe "new/1" do
    test "returns a employee" do
      employee_map = %{name: "Foo Bar", rating: "4.0"}

      assert %Volcspy.Employee{name: "Foo Bar", employee_rating: "4.0"} ==
               Employee.new(employee_map)
    end
  end
end
