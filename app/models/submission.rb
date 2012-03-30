class Submission < ActiveRecord::Base
  validates :title, :presence => true
  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true

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
end
