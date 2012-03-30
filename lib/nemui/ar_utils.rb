module Nemui::ArUtils
  def obj_name(obj)
    obj or return ""
    obj.respond_to?(:name) and return "#{obj.name}"
    obj.respond_to?(:login) and return "#{obj.login}"
    obj.respond_to?(:id) and return "#{obj.class.name}#{obj.id}"
  end

  def ar_t(obj, key)
    if obj.is_a? ActiveRecord::Base 
      t("activerecord.attributes.#{obj.class.name.underscore}.#{key}")
    elsif obj.is_a? ActionView::Helpers::FormBuilder
      t("activerecord.attributes.#{obj.object_name}.#{key}")
    else
      t("activerecord.attributes.#{obj.to_s.underscore}.#{key}")
    end
  end
end
