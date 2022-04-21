require 'test_helper'

class ProductStepCellTest < Cell::TestCase
  test "show" do
    html = cell("product_step").(:show)
    assert html.match /<p>/
  end


end
