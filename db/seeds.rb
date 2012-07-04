# -*- encoding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = YAML.load_file "#{Rails.root}/db/seed_data/categories.yml"
cats.each do |cat|
  if c = Category.find_by_name(cat['name'])
    c.update_attributes! cat
  else
    Category.create! cat
  end
end

subcats = YAML.load_file "#{Rails.root}/db/seed_data/sub_categories.yml"
subcats.each do |subcat|
  if sc = SubCategory.where(:name => subcat['name'], :group_id => subcat['group_id']).first
    sc.update_attributes! subcat
  else
    SubCategory.create! subcat
  end
end
