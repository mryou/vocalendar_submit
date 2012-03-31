module Nemui
  module Utils
    def datetime_copy(base, overrides = {})
      if base.blank?
        base = DateTime.now
      elsif base.is_a?(Date)
        base = DateTime.new(base.year, base.month, base.day, 0, 0, 0, DateTime.now.offset)
      elsif !base.is_a?(DateTime)
        base = DateTime.parse(base.to_s)
      end
      di = []
      overrides[:month] ||= overrides[:mon]
      %w(year month day hour min sec offset).each do |key|
        e = overrides[key.to_sym] || base.__send__(key)
        di.push key == 'offset' ? e : e.to_i
      end
      logger.debug(di)
      DateTime.new(*di)
    end

    def day_range(date_start, date_end = nil)
      date_end ||= date_start
      s = datetime_copy(date_start, :hour => 0, :min => 0, :sec => 0)
      e = datetime_copy(date_end, :hour => 23, :min => 59, :sec => 59)
      s..e
    end

  end
end
