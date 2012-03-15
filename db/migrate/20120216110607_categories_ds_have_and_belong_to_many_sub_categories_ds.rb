class CategoriesDsHaveAndBelongToManySubCategoriesDs < ActiveRecord::Migration
  def self.up
      create_table   :categories_ds_sub_categories_ds, :id => false do |t|
        t.references :categories_d,:sub_categories_d
      end
    end

    def self.down
      drop_table     :categories_ds_sub_categories_ds
    end
end
