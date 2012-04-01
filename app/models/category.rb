class Category < ActiveRecord::Base
  default_scope order('order_class, name')
  
  has_many :submissions

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 10 }
  validates :order_class, :numericality => true

  attr_accessible :name, :order_class, :description

  def name_with_desc
    self.description.blank? and return self.name
    "#{self.name} (#{self.description[0..50]})"
  end

end
