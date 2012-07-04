class SubCategory < ActiveRecord::Base
  default_scope order('group_id, order_class')
  scope :available, where(:disabled => false)

  attr_accessible :name, :order_class, :description, :disabled, :group_id
  
  validates :name, :presence => true, :length => { :maximum => 10 }
  validates :order_class, :numericality => true
  validates :group_id, :numericality => true, :presence => true

  def name_with_desc
    self.description.blank? and return self.name
    "#{self.name} (#{self.description[0..50]})"
  end
end
