defmodule Volcspy.ReviewParser do
  def get_date(review) do
    [{_tag_name, _attributes, children_nodes}] = Floki.find(review, ".review-date")
    children_nodes
  end
end
