class SubCategoriesD < ActiveRecord::Base
  # Sub categories belongs to one categories
  has_and_belongs_to_many                  :categories_ds
  attr_accessible                          :name, :categories_d_ids
end
