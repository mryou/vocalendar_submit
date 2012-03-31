module Nemui::ArUtils
  def obj_name(obj)
    obj or return ""
    obj.respond_to?(:name) and return "#{obj.name}"
    obj.respond_to?(:login) and return "#{obj.login}"
    obj.respond_to?(:id) and return "#{obj.class.name}#{obj.id}"
  end

end
