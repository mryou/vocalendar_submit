# -*- encoding: utf-8 -*-
class Submission < ActiveRecord::Base
  include Nemui::Utils

  belongs_to :category
  belongs_to :sub_category

  before_validation :set_end_datetime
  before_validation :clear_time_when_all_day
  before_validation :url_encode_badchar
  before_save :set_accepted_at

  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :where, :length => { :maximum => 300 }
  validates :description, :length => { :maximum => 2000 }
  validates :start_datetime, :presence => true
  validates :category_id, :presence => true
  validate :check_url
  validate :check_valid_end_datetime
  validate :check_sub_category

  attr_accessible :title, :where, :description, :url,
    :start_datetime, :start_date, :start_time,
    :end_datetime, :end_date, :end_time,
    :category_id, :category_name, :status_id, :all_day,
    :sub_category_id

  STATUS_ID_NAME_MAP = {1 => :new, 2 => :accepted, 3 => :rejected, 4 => :spam}
  STATUS_NAME_ID_MAP = STATUS_ID_NAME_MAP.invert
  @@status_id_by_name = Struct.new(*STATUS_ID_NAME_MAP.values).new(*STATUS_ID_NAME_MAP.keys)
  @@status_name_by_id = Struct.new(*STATUS_ID_NAME_MAP.keys.map{|k|k.to_s.to_sym}).new(*STATUS_ID_NAME_MAP.values)
  @@status_collection = STATUS_ID_NAME_MAP.map do |k, v|
    Struct.new(:id, :name, :human_name).new(k, v, I18n.t("status_names.#{v}"))
  end

  class << self
    def status
      @@status_id_by_name
    end

    def status_id
      @@status_name_by_id
    end

    def statuses
      @@status_collection
    end
    alias_method :status_collection, :statuses
  end

  def initalize
    @need_accepted_at = false
  end
  attr_accessor :need_accepted_at
  alias_method :need_accepted_at?, :need_accepted_at

  def full_category_name
    c = self.category.try(:name)
    s = self.sub_category.try(:name)
    s ? [c, s].join("/") : c
  end

  def sub_category_name
    self.sub_category.try(:name)
  end

  def category_name
    self.category.try(:name)
  end

  def category_name=(v)
    c = Category.find_by_name(v)
    self.category_id = c.try(:id)
  end

  def status
    STATUS_ID_NAME_MAP[self.status_id.to_i]
  end

  def human_status
    I18n.t("status_names." + STATUS_ID_NAME_MAP[self.status_id.to_i].to_s)
  end

  def status=(v)
    self.status_id = /^[0-9]+$/.match(v.to_s) ? v.to_i : STATUS_NAME_ID_MAP[v.to_s.to_sym]
  end

  def status_id=(v)
    v.blank? and return v
    old_sym = self.status
    self[:status_id] = v.to_i
    if old_sym == :new && STATUS_ID_NAME_MAP[v.to_i] != :new
      self.need_accepted_at = true
    end
    v
  end

  def start_date
    start_datetime.try(:to_date)
  end

  def end_date
    end_datetime.try(:to_date)
  end

  def start_date=(d)
    d.blank? and return
    d = force_to_date(d)
    self.start_datetime = datetime_copy(self.start_datetime, :year => d.year, :month => d.month, :day => d.day)
  end

  def end_date=(d)
    d.blank? and return
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
    t.blank? and return
    t = force_to_time(t)
    self.start_datetime = datetime_copy(self.start_datetime, :hour => t.hour, :min => t.min, :sec => t.sec)
  end

  def end_time=(t)
    t.blank? and return
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

  def check_url
    self.url.blank? and return
    self.url.strip.blank? and return
    %r{^https?://[a-zA-Z0-9_]+\.}.match(url) and return
    errors.add :url, "が正しくありません"
  end

  def check_sub_category
    cat = Category.find_by_id(self.category_id) or return
    cat.sub_categories.length < 1 and return
    if self.sub_category_id.blank?
      errors.add :sub_category_id, "を選択して下さい"
      return
    end
    cat.sub_categories.each do |sc|
      self.sub_category_id == sc.id and return
    end
    errors.add :sub_category_id, "が正しくありません"
  end

  def set_accepted_at
    need_accepted_at? or return true
    self[:accepted_at] = Time.now
  end

  def url_encode_badchar
    self.url.blank? and return true
    self.url = URI.escape(self.url.strip, /[^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]%]/n)
    true
  end
end
