class Category < ActiveRecord::Base
  default_scope order('order_class, name')
  scope :available, where(:disabled => false)
  
  subcat_cond =  
  has_many :sub_categories,
    :finder_sql => Proc.new { SubCategory.where({:disabled => false, :group_id => sub_category_group_id}).to_sql },
    :counter_sql => Proc.new { SubCategory.where({:disabled => false, :group_id => sub_category_group_id}).count.to_sql }
  

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 10 }
  validates :order_class, :numericality => true

  attr_accessible :name, :order_class, :description, :disabled, :sub_category_group_id

  def name_with_desc
    self.description.blank? and return self.name
    "#{self.name} (#{self.description[0..50]})"
  end

end
