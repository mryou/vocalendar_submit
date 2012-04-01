require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test "simple save" do
    sub = submissions(:one)
    assert sub.save, "simple save failed"
  end

  test "auto set end date by start date" do
    attrs = submissions(:one).attributes
    attrs.delete "end_datetime"
    submission = Submission.new attrs
    assert submission.save, "save fail without end datetime"
    assert_equal submission.end_datetime, submission.start_datetime, "start and end date is different"
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

  test "end time before start time validation fails" do
    s = submissions(:one)
    s.end_datetime = s.start_datetime - 3.days
    assert !s.save, "save success when end time < start time"
  end

  test "start time setting" do
    s = submissions(:one)
    old = s.start_datetime.dup
    s.start_time = "03:14"
    assert_equal s.start_datetime.hour, 3
    assert_equal s.start_datetime.min, 14
    assert_equal s.start_datetime.year, old.year
    assert_equal s.start_datetime.mon, old.mon
    assert_equal s.start_datetime.day, old.day
  end

  test "start date setting" do
    s = submissions(:one)
    old = s.start_datetime.dup
    s.start_date = "1997-4-23"
    assert_equal s.start_datetime.hour, old.hour
    assert_equal s.start_datetime.min, old.min
    assert_equal s.start_datetime.year, 1997
    assert_equal s.start_datetime.mon, 4
    assert_equal s.start_datetime.day, 23
  end

  test "clear time by setting all day" do
    s = submissions(:one)
    s.all_day = true
    assert s.save, "save fail with all_day = true"
    assert_equal s.start_time, "00:00"
    assert_equal s.end_time, "00:00"
  end

  test "set accepted_at" do
    s = submissions(:one)
    s.save
    assert !s.accepted_at, "accepted_at should not be set with new status"
    s.status = Submission.status.accepted
    s.save
    assert s.accepted_at, "accepted_at should be set with non-new status"
  end

end
