# -*- encoding: utf-8 -*-
module SubmissionsHelper
  def gcal_add_link(sub, label, attrs = {})
    urlbase = 'http://www.google.com/calendar/event?action=TEMPLATE&'
    cat_prefix = sub.category_name ? "【#{sub.category_name}】" : ''
    attrs = {
      :text => cat_prefix + sub.title,
      :src => Rails.configuration.private_calendar_ids.values.first,
    }.merge(attrs)
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
    unless sub.url.blank?
      attrs[:sprop] = "website:" + sub.url.sub(%r{^https?://}, '')
      attrs[:details].blank? or attrs[:details] += "\n\n"
      attrs[:details] = attrs[:details].to_s + "URL: #{sub.url}"
    end
    url = urlbase + attrs.map{|k, v| "#{k}=#{CGI.escape(v)}"}.join('&')
    link_to label, url, :target => '_blank'
  end

  def render_list(subs, opts = {})
    opts = {
      :columns => [:id, :category, :title, :created_at, :accepted_at, :status],
      :datetime_format => "%m/%d %H:%M",
      :enable_filter_link => false,
      :target_subs => subs,
    }.merge opts
    render :partial => 'listing_table', :locals => opts
  end
end
