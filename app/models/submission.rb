# -*- encoding: utf-8 -*-
class Submission < ActiveRecord::Base
  include Nemui::Utils

  before_validation :set_end_datetime
  before_validation :clear_time_when_all_day

  validates :title, :presence => true
  validates :start_datetime, :presence => true
  validate :check_valid_end_datetime

  STATUS_ID_NAME_MAP = {1 => :new, 2 => :accepted, 3 => :rejected, 4 => :spam}
  STATUS_NAME_ID_MAP = STATUS_ID_NAME_MAP.invert
  @@status_id_by_name = Struct.new(*STATUS_ID_NAME_MAP.values).new(*STATUS_ID_NAME_MAP.keys)

  def self.status
    @@status_id_by_name
  end

  def status
    STATUS_ID_NAME_MAP[self.status_id.to_i]
  end

  def status=(v)
    self.status_id = /^[0-9]+$/.match(v.to_s) ? v.to_i : STATUS_NAME_ID_MAP[v.to_s.to_sym]
  end

  def start_date
    start_datetime.try(:to_date)
  end

  def end_date
    end_datetime.try(:to_date)
  end

  def start_date=(d)
    d = force_to_date(d)
    self.start_datetime = datetime_copy(self.start_datetime, :year => d.year, :month => d.month, :day => d.day)
  end

  def end_date=(d)
    d = force_to_date(d)
    self.end_datetime = datetime_copy(self.end_datetime, :year => d.year, :month => d.month, :day => d.day)
  end

  def start_time
    start_datetime.try(:strftime, "%H:%M")
  end

  def end_time
    end_datetime.try(:strftime, "%H:%M")
  end

  def start_time=(t)
    t = force_to_time(t)
    self.start_datetime = datetime_copy(self.start_datetime, :hour => t.hour, :min => t.min, :sec => t.sec)
  end

  def end_time=(t)
    t = force_to_time(t)
    self.end_datetime = datetime_copy(self.end_datetime, :hour => t.hour, :min => t.min, :sec => t.sec)
  end

  private
  def force_to_date(d)
    begin
      d.is_a?(Date) and return d
      d = d.to_date
      d.blank? ? Date.today : d
    rescue
      return Date.today
    end
  end

  def force_to_time(t)
    begin
      t.is_a?(DateTime) and return t
      return DateTime.parse(t.to_s)
    rescue
      return DateTime.now
    end
  end

  def set_end_datetime
    self.end_datetime.blank? or return true
    self.end_datetime = self.start_datetime
    true
  end
  
  def clear_time_when_all_day
    self.all_day? or return true
    t = DateTime.new(2000, 1, 1, 0, 0, 0)
    self.start_time = t
    self.end_time = t
    true
  end

  def check_valid_end_datetime
    self.start_datetime.blank? || self.end_datetime.blank? and return
    self.start_datetime <= self.end_datetime and return
    errors.add :end_datetime, "が開始日より前になっています"
  end
end
