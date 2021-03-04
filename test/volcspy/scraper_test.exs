defmodule Volcspy.ScraperTest do
  use ExUnit.Case

  alias Volcspy.Scraper

  import Mox
  setup :verify_on_exit!

  describe "get_reviews/0" do
    test "returns a list of reviews" do
      expect(HTTPoison.BaseMock, :get, 5, fn _ ->
        {:ok, %HTTPoison.Response{status_code: 200, body: fake_html()}}
      end)

      assert [
               {"div", [{"class", "review-entry"}], ["FOO"]},
               {"div", [{"class", "review-entry"}], ["FOO"]},
               {"div", [{"class", "review-entry"}], ["FOO"]},
               {"div", [{"class", "review-entry"}], ["FOO"]},
               {"div", [{"class", "review-entry"}], ["FOO"]}
             ] ==
               Scraper.get_reviews()
    end
  end

  defp fake_html() do
    "<!doctype html>
    <html>
    <body>
      <section id=\"content\">
        <div class=\"review-entry\">FOO</div>
    </body>
    </html>"
  end
end
