require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "simple save" do
    c1 = rand_cat
    assert c1.save, "simple save failed"
  end

  test "validate fail on name uniqueness" do
    c1 = rand_cat
    c1.save
    c2 = Category.new cat_allowed_attrs(c1)
    assert !c2.save, "save success with same name"
  end

  test "validate fail with empyt name" do
    c = rand_cat
    c.name = ''
    assert !c.save, "save success with empty name"
  end
end
