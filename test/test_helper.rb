ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def rand_cat
    Category.new :name => "c#{SecureRandom.base64(6)}"
  end

  def allowed_attrs(o)
    ret = {}
    o.class.accessible_attributes.each do |attr|
      o.attribute_names.member? attr or next
      ret[attr] = o.__send__ attr
    end
    ret
  end
end
