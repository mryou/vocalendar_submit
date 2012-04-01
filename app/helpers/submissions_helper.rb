# -*- encoding: utf-8 -*-
module SubmissionsHelper
  def gcal_add_button(sub)
    urlbase = 'http://www.google.com/calendar/event?action=TEMPLATE&'
    attrs = {
      :text => sub.title,
      :src => Rails.configuration.private_calendar_id,
    }
    if sub.all_day?
      attrs[:dates] = sub.start_datetime.strftime("%Y%m%d") +
        '/' + (sub.end_datetime + 1.day).strftime("%Y%m%d")
      # why do google need +1 day...
    else
      fmt = "%Y%m%dT%H%M00Z"
      attrs[:dates] = sub.start_datetime.to_datetime.new_offset(0).strftime(fmt) +
        '/' + sub.end_datetime.to_datetime.new_offset(0).strftime(fmt)
    end
    sub.where.blank? or  attrs[:location] = sub.where
    sub.description.blank? or  attrs[:details] = sub.description
    url = urlbase + attrs.map{|k, v| "#{k}=#{CGI.escape(v)}"}.join('&')
    link_to 'Googleカレンダーの編集画面を開く', url, :class => 'action-button main-action add-google-cal', :target => '_blank'
  end
end
