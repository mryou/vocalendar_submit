require 'test_helper'

class SubCategoryTest < ActiveSupport::TestCase
  test "simple save" do
    sc = sub_categories(:one)
    assert sc.save, "simple save failed: #{sc.errors.inspect}"
  end
end
