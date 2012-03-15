class CategoriesD < ActiveRecord::Base
  has_and_belongs_to_many              :docters
  # Categories has many sub categoires
  has_and_belongs_to_many                 :sub_categories_ds
  attr_accessible         :name,:docter_ids, :sub_categories_d_ids
 

end
