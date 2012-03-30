require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test "simple save" do
    sub = submissions(:one)
    assert sub.save, "simple save"
  end

  test "end datetime validation fails" do
    attrs = submissions(:one).attributes
    attrs.delete "end_datetime"
    submission = Submission.new attrs
    assert !submission.save, "save success without end datetime"
  end

  test "start datetime validation fails" do
    attrs = submissions(:one).attributes
    attrs.delete "start_datetime"
    submission = Submission.new attrs
    assert !submission.save, "save success without start datetime"
  end

  test "title validation fails" do
    attrs = submissions(:one).attributes
    attrs.delete "title"
    submission = Submission.new attrs
    assert !submission.save, "save success without title"
  end
end
